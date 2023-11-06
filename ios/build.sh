#!/bin/sh
set -e
echo "Build Env Info:Build FLUTTER_VERSION:$FLUTTER_VERSION,Build FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
echo "Build Params Info:Build Dir:$GITHUB_WORKSPACE,Build Tag:$CURRENT_TAG,Build Branch:$CURRENT_BRANCH,Build BUILD_REVISION:$BUILD_REVISION"

bundle install --gemfile ios/Gemfile
flutter pub get
cd $GITHUB_WORKSPACE/ios
# 解决Flutter.xcframework must exist. If you're running pod install manually, make sure flutter build ios_ is executed first
flutter precache --ios
bundle exec pod install --repo-update
echo "===Fastlane env output==="
bundle exec fastlane env
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles*

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    echo "===Building iOS Release==="
#    sh $GITHUB_WORKSPACE/ios_/fastlane/build_release.sh
#    cp "$GITHUB_WORKSPACE/ios_/fastlane/ipas/ones_mobile.ipa" "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_TAG.ipa"
    bundle exec fastlane release --verbose
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]] || [[ "${CURRENT_BRANCH}" == "flutter_beta_migration" ]]; then
    echo "===Building iOS Beta==="
#    sh $GITHUB_WORKSPACE/ios_/fastlane/build_beta.sh
#    cp "$GITHUB_WORKSPACE/ios_/fastlane/ipas/ones_mobile.ipa"  "$GITHUB_WORKSPACE/ones-ai-mobile-$CURRENT_BRANCH.ipa"
    bundle exec fastlane beta --verbose
fi
exit 0