# [1.7.0-beta.1](https://github.com/RA341/gouda/compare/v1.6.0...v1.7.0-beta.1) (2025-10-03)


### Bug Fixes

* loop time to a 1 minute ([8c609ef](https://github.com/RA341/gouda/commit/8c609efc69ef06b1b09564469fd9315a12dfa2cd))
* refactored service and api handlers ([5f7ce01](https://github.com/RA341/gouda/commit/5f7ce019e93e530d05e63c2f07a5f6da05bcb4d2))


### Features

* added setup page ([faabe42](https://github.com/RA341/gouda/commit/faabe42006531d4cf6089342474c5a0c6202c052))

# [1.6.0](https://github.com/RA341/gouda/compare/v1.5.2...v1.6.0) (2025-01-16)


### Features

* added series info ([229738b](https://github.com/RA341/gouda/commit/229738b64ae7603b197164de1a7d4491018ba348))
* deluge support (beta) ([aa5096c](https://github.com/RA341/gouda/commit/aa5096ce2081b8a768bfcfcd23449730abb64a30))
* embed frontend files in binary ([09f3665](https://github.com/RA341/gouda/commit/09f36653a8e5d58089b8c0e33efbbba3a21c6b25))

## [1.5.2](https://github.com/RA341/gouda/compare/v1.5.1...v1.5.2) (2025-01-09)


### Bug Fixes

* return value ([ca657a9](https://github.com/RA341/gouda/commit/ca657a9544df31fdf6f5028cb028b9803d69151e))

## [1.5.1](https://github.com/RA341/gouda/compare/v1.5.0...v1.5.1) (2025-01-09)


### Bug Fixes

* changed return value ([e22de71](https://github.com/RA341/gouda/commit/e22de71baa529db7fc63429d1e6adbfbcaf31bc6))

# [1.5.0](https://github.com/RA341/gouda/compare/v1.4.1...v1.5.0) (2025-01-09)


### Features

* added search and pagination ([539b11a](https://github.com/RA341/gouda/commit/539b11a5b04fa1f05a1112cc3b650299fa2a0ac9))

## [1.4.1](https://github.com/RA341/gouda/compare/v1.4.0...v1.4.1) (2024-12-24)


### Bug Fixes

* moved timeout out of for loop ([99b4bae](https://github.com/RA341/gouda/commit/99b4bae40b032e895fada8d48d1f2b574a651480))

# [1.4.0](https://github.com/RA341/gouda/compare/v1.3.6...v1.4.0) (2024-12-21)


### Bug Fixes

* db logging only on debug ([a7d7ef7](https://github.com/RA341/gouda/commit/a7d7ef7bea4a2234bb83abf16e4a68ae0fd5f76c))
* docker base image to alpine ([f6fc98a](https://github.com/RA341/gouda/commit/f6fc98a9f32e997f79c5aa8b1753b9e833fdbe8d))
* linter warnings ([f97cc24](https://github.com/RA341/gouda/commit/f97cc24707ee268ff0acdad4a6d4b888fee139b8))
* process downloads is fully independent ([bac4b60](https://github.com/RA341/gouda/commit/bac4b60e34e90509ca0997061494d6dce1a0e941))
* **ui:** general improvements ([bbabfb7](https://github.com/RA341/gouda/commit/bbabfb7ad747b9d00006f00d9a693f60aa0a5f0d))


### Features

* added more history endpoints ([d759ddd](https://github.com/RA341/gouda/commit/d759ddd856b890d5e3fedc855f9a8005d16a4029))
* added request history ([6584e0a](https://github.com/RA341/gouda/commit/6584e0ab2fc9415b874698ab1b913d7b548e14f0))
* changed status check signature ([1e9b30a](https://github.com/RA341/gouda/commit/1e9b30a4d9f6a448f157335dce2ee6c6f3f07330))
* switched to sqlite for storage, changed api specs ([04fd3f3](https://github.com/RA341/gouda/commit/04fd3f3718c8977fbc04345dfb14128890d5dda7))

## [1.3.6](https://github.com/RA341/gouda/compare/v1.3.5...v1.3.6) (2024-12-19)


### Bug Fixes

* added qbit referer header and refactored some functions ([a725190](https://github.com/RA341/gouda/commit/a7251901126ff075a0a5f6558d49cc29927bb972))
* changed file creation perm ([d242990](https://github.com/RA341/gouda/commit/d242990525cb28d0e9c2dc2f457b87cc2ae72fe0))
* changed status check to bool ([ca44ea9](https://github.com/RA341/gouda/commit/ca44ea9de2cf2fd52504e7f327c032250e33acbd))


### Performance Improvements

* added debug variable cache ([52d38d4](https://github.com/RA341/gouda/commit/52d38d40fca517329c1b51deb9ae33e23c13aff7))

## [1.3.5](https://github.com/RA341/gouda/compare/v1.3.4...v1.3.5) (2024-12-15)


### Bug Fixes

* **ui:** broken page after login ([eab9191](https://github.com/RA341/gouda/commit/eab9191ae42a199d3fe88422d00cb6ae51da56e7))

## [1.3.4](https://github.com/RA341/gouda/compare/v1.3.3...v1.3.4) (2024-12-15)


### Bug Fixes

* **ui:** show full path in cat rows ([2de667f](https://github.com/RA341/gouda/commit/2de667f038d51f7447ccf47868f0bec90351e865))

## [1.3.3](https://github.com/RA341/gouda/compare/v1.3.2...v1.3.3) (2024-12-14)


### Bug Fixes

* **ui:** removed fade in, add back later ([e4e55b3](https://github.com/RA341/gouda/commit/e4e55b30775f19270ac18133412d75967f5bbf13))

## [1.3.2](https://github.com/RA341/gouda/compare/v1.3.1...v1.3.2) (2024-12-14)


### Bug Fixes

* **ui:** added splash and fade in transition ([7d2c903](https://github.com/RA341/gouda/commit/7d2c9035ba2b8094bbf6dc5f447f60b9af8357ae))

## [1.3.1](https://github.com/RA341/gouda/compare/v1.3.0...v1.3.1) (2024-12-14)


### Bug Fixes

* **ui:** changed copy button color ([1736042](https://github.com/RA341/gouda/commit/1736042083f376af191d6d3b800948abb76ff38d))

# [1.3.0](https://github.com/RA341/gouda/compare/v1.2.1...v1.3.0) (2024-12-14)


### Bug Fixes

* changed int64 id to string id ([7f52875](https://github.com/RA341/gouda/commit/7f52875b5c22b64642d91eed8390fea0e497714a))


### Features

* added qbit support ([a609d46](https://github.com/RA341/gouda/commit/a609d46a238b09c5b2164132ceb934617abb6386))
* changed endpoints ([9ffe90d](https://github.com/RA341/gouda/commit/9ffe90dd9d32cfab6fd856b27e8aa88fa16deed2))

## [1.2.1](https://github.com/RA341/gouda/compare/v1.2.0...v1.2.1) (2024-12-09)


### Bug Fixes

* broken ui repo ([ddb209a](https://github.com/RA341/gouda/commit/ddb209aa4759ed3b2dcc73964231501990d0df60))


### Reverts

* Revert "ci: removed no cache" ([d5b1e3f](https://github.com/RA341/gouda/commit/d5b1e3fe5b968a8fdd06cf1da06c429a115ee62b))
* Revert "docs: readme" ([8d79fc6](https://github.com/RA341/gouda/commit/8d79fc687ea2d1aeeecc71afc8e61f20c74528c2))
* Revert "feat: moved frontend to core" ([ba7dd4f](https://github.com/RA341/gouda/commit/ba7dd4f2c8218e34629ecc079ef33aa80a00c3e8))
* Revert "fix(ui): cleanup" ([957e655](https://github.com/RA341/gouda/commit/957e6554650a8e120527125d684c2c6da255603e))

# [1.2.0](https://github.com/RA341/gouda/compare/v1.1.1...v1.2.0) (2024-12-09)


### Bug Fixes

* **ui:** cleanup ([f7eed1f](https://github.com/RA341/gouda/commit/f7eed1fac255939b6f6770e4489e9f489ebfd4ac))


### Features

* moved frontend to core ([56b7866](https://github.com/RA341/gouda/commit/56b78662cd97d4ad6f258404eb101069545db057))

## [1.1.1](https://github.com/RA341/gouda/compare/v1.1.0...v1.1.1) (2024-12-08)


### Bug Fixes

* write to config ([a5c5e6d](https://github.com/RA341/gouda/commit/a5c5e6df8fda467edd877c61a46e76e2eef40b7a))

# [1.1.0](https://github.com/RA341/gouda/compare/v1.0.5...v1.1.0) (2024-12-08)


### Features

* added basic webui ([0614a2c](https://github.com/RA341/gouda/commit/0614a2c20527f8f32d8600ba344355cac8415f32))
* added settings and cleanup ([00c2fb7](https://github.com/RA341/gouda/commit/00c2fb733d0d42550d9248244db51b7529601124))

## [1.0.5](https://github.com/RA341/gouda/compare/v1.0.4...v1.0.5) (2024-12-08)


### Bug Fixes

* cleanup dockerfile ([c3282d8](https://github.com/RA341/gouda/commit/c3282d8868a3f556b9e59f56ee087091b82c117a))

## [1.0.4](https://github.com/RA341/gouda/compare/v1.0.3...v1.0.4) (2024-12-08)


### Bug Fixes

* added categories endpoints ([6a88eef](https://github.com/RA341/gouda/commit/6a88eef700e93c16fe5395b89318eccbd0392750))

## [1.0.3](https://github.com/RA341/gouda/compare/v1.0.2...v1.0.3) (2024-12-08)


### Bug Fixes

* added categories ([0e18e50](https://github.com/RA341/gouda/commit/0e18e5083041ffef782b0029235e3563f37fd891))

## [1.0.2](https://github.com/RA341/gouda/compare/v1.0.1...v1.0.2) (2024-12-08)


### Bug Fixes

* file perm ([dcaeea8](https://github.com/RA341/gouda/commit/dcaeea819fc73a4ca202195020be8ae5621cc63c))

## [1.0.1](https://github.com/RA341/gouda/compare/v1.0.0...v1.0.1) (2024-12-08)


### Bug Fixes

* cleanup ([31e9b66](https://github.com/RA341/gouda/commit/31e9b6655df4af15d466bc8f5fffe181cae75d94))

# 1.0.0 (2024-12-08)


### Features

* initial release ([b9b3dd3](https://github.com/RA341/gouda/commit/b9b3dd3fba104a483d72f0b495f417b50dbe0b2c))
