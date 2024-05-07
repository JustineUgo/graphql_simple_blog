
get: ## Get all dependencies
	flutter pub get

codegen: ## Generate code with build_runner
	flutter packages pub run build_runner build --delete-conflicting-outputs

check: 
	flutter analyze
	flutter test

setup: get codegen


#################
## BUILD AND RELEASE
################

build-android:
	flutter build apk --release
	flutter build appbundle


build-ios:
	flutter build ipa --no-codesign --release

