#!/usr/bin/env bash
set -euo pipefail

# Nothing bun-base-wo-helm stripped comes back, and no observability surface
# arrives: no Helm path, reference, job, include, probe row or helm-carrying
# nix aggregate; no helm binary in the default shell; no OpenTelemetry or
# @atomicloud/diene.* observability dependency, import or variable.

cd "$(git rev-parse --show-toplevel)"
# index tree == HEAD in CI; keeps local staged mutations visible
tree="$(git write-tree)"
failed=0

fail() {
  echo "❌ $*" >&2
  failed=1
}

# The parent's H ledger (.github/named-checks/bun-base-wo-helm/helm-absence.sh).
H_PATHS=(
  infra/root_chart
  '.github/workflows/⚡reusable-helm.yaml'
  tasks/Taskfile.helm.yaml
  scripts/ci/helm.sh
  .claude/skills/helm-push
  docs/standards/helm
  probes/helm-lint.ts
  probes/helm-render.ts
  probes/hook-helm-lint.ts
  .helmignore
)
H_TOKENS=(
  root_chart reusable-helm Taskfile.helm helm.sh helm-push standards/helm
  helm/index.md a-helm-lint helm-lint helm-render
)
# Observability (O) surface: the payload descendants add, never this node.
O_TOKENS=(@opentelemetry/ opentelemetry diene.otel OTEL_EXPORTER otel-collector)
# The declaration itself; machine-maintained history; the probe harness whose
# command-string fixtures are generic and name no axis file.
SCAN_EXEMPT=(':!.github/named-checks/**' ':!Changelog.md' ':!Changelog.old.md' ':!probes/lib/**')

for p in "${H_PATHS[@]}"; do
  if [[ -n "$(git ls-tree --name-only "${tree}" -- "${p}")" ]]; then fail "H path tracked: ${p}"; fi
done

args=()
for t in "${H_TOKENS[@]}" "${O_TOKENS[@]}"; do args+=(-e "${t}"); done
hits="$(git -c core.quotePath=false grep -n -F "${args[@]}" "${tree}" -- . "${SCAN_EXEMPT[@]}" || true)"
[[ -z ${hits} ]] || fail "files reference a stripped Helm or observability surface:"$'\n'"${hits}"

show() { git show "${tree}:$1"; }
[[ "$(show .github/workflows/ci.yaml | yq '.jobs | has("helm")')" == false ]] || fail "ci.yaml has a helm job"
[[ "$(show .github/workflows/cd.yaml | yq '.jobs | has("helm")')" == false ]] || fail "cd.yaml has a helm job"
[[ "$(show Taskfile.yaml | yq '.includes | has("helm")')" == false ]] || fail "Taskfile.yaml includes helm"
[[ "$(show .github/dependabot.yml | yq '[.updates[] | select(.package-ecosystem == "helm")] | length')" == 0 ]] || fail "dependabot.yml has a helm entry"
[[ "$(show probes/features.json | jq '[.[] | select(.name | test("helm|otel|observability"))] | length')" == 0 ]] || fail "features.json has a helm or observability row"
deps="$(show package.json | jq -r '[(.dependencies // {}), (.devDependencies // {}), (.peerDependencies // {})] | add | keys[] | select(test("^@opentelemetry/|^@atomicloud/diene\\."))')"
[[ -z ${deps} ]] || fail "package.json declares observability dependencies: ${deps//$'\n'/, }"

for f in nix/packages.nix nix/env.nix; do
  if show "${f}" | grep -v '^ *#' | grep -Eq '(^|[^A-Za-z0-9-])(infralint|infrautils|kubernetes-helm|helm|helm-docs|helmlint)([^A-Za-z0-9-]|$)'; then
    fail "${f} declares a helm-carrying package"
  fi
done

# -i clears the caller's PATH, so only the shell's own inputs resolve. The
# positive control proves the lookup is not vacuous.
# shellcheck disable=SC2016
nix develop -i --keep HOME .#default -c bash -c '
  set -u
  bad=0
  for b in helm helm-docs helmlint; do
    if p="$(command -v "$b")"; then echo "❌ default shell carries $b at $p" >&2; bad=1; fi
  done
  for b in docker bun goreleaser; do
    command -v "$b" >/dev/null || { echo "❌ control: default shell lost $b" >&2; bad=1; }
  done
  exit "$bad"
' || fail "default shell helm absence / control presence"

if [[ ${failed} -ne 0 ]]; then
  exit 1
fi

echo "✅ strip-absence: no Helm or observability path, reference, entry, dependency, nix aggregate or shell binary"
