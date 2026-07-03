#!/usr/bin/env bash
set -euo pipefail

# Entry from package.json .bin (like compile.sh) — never hardcode the sample name.
ENTRY="$(jq -r '.bin | to_entries[0].value' package.json)"
[ -z "${ENTRY}" ] && echo "❌ no .bin entry in package.json" >&2 && exit 1
[ "${ENTRY}" = "null" ] && echo "❌ no .bin entry in package.json" >&2 && exit 1

ARTIFACT="dist/$(basename "${ENTRY}" .ts).js"

echo "🔨 Building CLI bundle..."
bun build "./${ENTRY}" --outdir ./dist --target bun

[ ! -f "${ARTIFACT}" ] && echo "❌ Build artifact missing: ${ARTIFACT}" >&2 && exit 1
echo "✅ Build artifact present: ${ARTIFACT}"
