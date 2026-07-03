## 1.0.0 (2026-07-03)


### ✨ Features ✨

* full CLI-authoring baseline (framework, binaries, publish, docs) ([bb7ebe1](https://github.com/AtomiCloud/diene.bun-cli/commit/bb7ebe19587f8edb0382709dc19bb40f24b7a522))
* local setup script for pls setup ([8d72b03](https://github.com/AtomiCloud/diene.bun-cli/commit/8d72b03cb7d22320cf6e649539098768dd85dd5a))
* pls redis and cli:bin tasks for easy local trying ([2f66a9b](https://github.com/AtomiCloud/diene.bun-cli/commit/2f66a9bb7bc1d0c1dcc8d92016e5c6a97e4ebb0a))
* pls up/down/run/run:bin for standard local DX ([69796e6](https://github.com/AtomiCloud/diene.bun-cli/commit/69796e634d20bb3f521fbbe7f19a156cc4d5fa17))
* SIT tier — black-box journeys through the compiled binary ([cd41c21](https://github.com/AtomiCloud/diene.bun-cli/commit/cd41c218fc718921b6c277287183ce1ad7c417c1))
* spinner, progress bar, and shell-call samples ([2fdfd95](https://github.com/AtomiCloud/diene.bun-cli/commit/2fdfd955cd6fced7a7cfbb0d0647a6d64a9f1dde))


### 🐛 Bug Fixes 🐛

* bump.sh fails loudly if the version stamp is a no-op ([7a6818e](https://github.com/AtomiCloud/diene.bun-cli/commit/7a6818efd93491672ba37a371432f50991d21174))
* **ci:** compile job installs deps and calls script not pls ([ece67c7](https://github.com/AtomiCloud/diene.bun-cli/commit/ece67c7c9ce5be2994d1e5c430f9770774fdcc82))
* empty node_modules mountpoint instead of removing ([d9ae228](https://github.com/AtomiCloud/diene.bun-cli/commit/d9ae22869fddd398d1296217c92531a79a0c04bc))
* harden CLI teardown, release scripts, smoke workflow, image ([0ae24d1](https://github.com/AtomiCloud/diene.bun-cli/commit/0ae24d127855278830f50996ec174c3c3c5874e2))
* **test:** keep helper fakes out of unit coverage ([40eede3](https://github.com/AtomiCloud/diene.bun-cli/commit/40eede30e6102e5c0c8bb3adfddaff3b25d5e307))
* keep release commits lockfile-safe when stamping the version ([208ace1](https://github.com/AtomiCloud/diene.bun-cli/commit/208ace1695e214868bfb10f5536b2641d02ce092))
* reject Intel macOS in installer and bound the Gemfury curl ([c4ed4d0](https://github.com/AtomiCloud/diene.bun-cli/commit/c4ed4d0e2ed6ee0e9fe8783109a9cec08b3448fc))
* **test:** scope unit coverage to the domain tier ([611bda6](https://github.com/AtomiCloud/diene.bun-cli/commit/611bda6eb7bd0ead2f5c2f0fad0283537b063952))
* setup task calls setup.sh again ([7fdc877](https://github.com/AtomiCloud/diene.bun-cli/commit/7fdc877f780a442df1ea24d8e34a44bda73b1299))
* upload install.sh with the release; strip unused release surface ([1e1830a](https://github.com/AtomiCloud/diene.bun-cli/commit/1e1830a1381cd4982326dd25fa681d008b1c2293))
* version stamping, Redis env override, and evaluation cleanups ([99a48d7](https://github.com/AtomiCloud/diene.bun-cli/commit/99a48d7d5910e46493edbea50fe1262bf0cc524f))
* wipe cache-restored node_modules before release ([bfdcbb9](https://github.com/AtomiCloud/diene.bun-cli/commit/bfdcbb9728891a7db05471916c1326703ca98772))

## 1.0.0 (2026-06-29)


### 📜 Documentation 📜

* centralize bun baseline guidance ([3fefb7e](https://github.com/AtomiCloud/diene.bun-cli/commit/3fefb7ec0d85abf180683e7c1aef2f9fd4c81a11))
* keep top-level guides minimal ([c332530](https://github.com/AtomiCloud/diene.bun-cli/commit/c3325308c989ecdd2171ffc874978daabbc4a682))
* point bun baseline at AtomiCloud repo ([339a711](https://github.com/AtomiCloud/diene.bun-cli/commit/339a7118619c019ca11e85cada59d28eab65cbfc))
* trim bun baseline details ([14fb6ea](https://github.com/AtomiCloud/diene.bun-cli/commit/14fb6ea4183f585af731407a33e092cab2a94d51))


### ✨ Features ✨

* add bun template foundation ([585e5c4](https://github.com/AtomiCloud/diene.bun-cli/commit/585e5c4f7c1efefb0708f1a5de0b718bb05af3f3))
* initial commit ([697c555](https://github.com/AtomiCloud/diene.bun-cli/commit/697c55528c46a66b6bae685ad0de553df8b7e539))
* manual merge CLAUDE.md ([8b6d8ad](https://github.com/AtomiCloud/diene.bun-cli/commit/8b6d8adf62a7a1afd851923a508c4cfd9a5e2295))


### 🐛 Bug Fixes 🐛

* address bun baseline review findings ([e50b916](https://github.com/AtomiCloud/diene.bun-cli/commit/e50b916ff68bcaa123c52b49ab68cba64c863f85))
* align bun foundation cleanup ([877d7d9](https://github.com/AtomiCloud/diene.bun-cli/commit/877d7d90f5b26408bc49c2cf6628d87ba162a1bf))
* enforce runtime knip reachability ([031b6d3](https://github.com/AtomiCloud/diene.bun-cli/commit/031b6d3111f12a900dece89aac03773cac76e21a))
* grant package publish workflow permissions ([c518c64](https://github.com/AtomiCloud/diene.bun-cli/commit/c518c64fc4aaac106268c84f1cdf421cfbf085ba))
* keep production knip entry generic ([5194a80](https://github.com/AtomiCloud/diene.bun-cli/commit/5194a80647685cde1f2c2a208279792e30ca0615))
* remove knip contract hook ([5edaefc](https://github.com/AtomiCloud/diene.bun-cli/commit/5edaefc3df21f278991356db06cd6330416f6244))
* tighten bun baseline tooling ([adbac56](https://github.com/AtomiCloud/diene.bun-cli/commit/adbac56ef12c3698abf4c58832bcd8ba9244458e))
* use version-only image pins ([76d2fb5](https://github.com/AtomiCloud/diene.bun-cli/commit/76d2fb533b83b70b866fc2165e051cf267a4348e))
* wire codecov token in reusable tests ([4c168c7](https://github.com/AtomiCloud/diene.bun-cli/commit/4c168c7e1e2144eff148e6fec4fa19b10e12a2ac))
