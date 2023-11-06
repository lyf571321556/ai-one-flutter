#!/bin/bash
set -e
echo "Build Env Info:Build FLUTTER_VERSION:$FLUTTER_VERSION,Build FLUTTER_CHANNEL:$FLUTTER_CHANNEL"
echo "Build Params Info:Build Dir:$GITHUB_WORKSPACE,Build Tag:$CURRENT_TAG,Build Branch:$CURRENT_BRANCH,Build BUILD_REVISION:$BUILD_REVISION"
mark_last_build_revision() {
    mkdir -p "$LAST_BUILD_DIR"
    echo "$BUILD_REVISION" > "$LAST_BUILD_REVISION_FILE"
}

pkg_to_tarfile() {
    pwd
    echo "start package..."
    echo $WEB_OUTPUT_FILE
    rm -rf ./build/web/assets/assets/editor_package.zip
    ls -al ./build/web
    tar zcvf $WEB_OUTPUT_FILE -C ./build/web .
    ls -al .
    echo "finish package..."
}

build_mobile_web() {
    echo "start build..."
     echo $APP_VERSION
    flutter doctor
    flutter --version
    flutter config --enable-web
    git config --global url."https://${RELEASE_GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
    flutter pub get
    flutter build web --web-renderer html --release --source-maps --dart-define=appVersion="$APP_VERSION" --dart-define=sensorsDsn="${SENSORS_DSN}"
    echo "finish build..."
}

#git fetch --unshallow
#BUILD_REVISION=`git rev-list HEAD --count`

if [[ "${CURRENT_TAG}" =~ v[0-9]+.[0-9]+.[0-9]+ ]]; then
    WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$CURRENT_TAG.tar.gz"
    APP_VERSION="$CURRENT_TAG($BUILD_REVISION)"
    sed -i "s/1.0.0+1/${CURRENT_TAG:1}/g" pubspec.yaml
    build_mobile_web
    pkg_to_tarfile
    echo "start upload sourcemap for $CURRENT_TAG"
    flutter packages pub run sentry_dart_plugin --ignore-missing
    echo "finish upload sourcemap for $CURRENT_TAG"
    echo "finish build and upload artifacts for $CURRENT_TAG"
elif [[ "${CURRENT_BRANCH}" =~ F[0-9]+ ]] || [ "${CURRENT_BRANCH}" == "ones_beta_migration" ] || [ "${CURRENT_BRANCH}" == "beta" ]; then
    WEB_OUTPUT_FILE="$GITHUB_WORKSPACE/ones-ai-mobile-web-$CURRENT_BRANCH.tar.gz"
    APP_VERSION="$CURRENT_BRANCH($BUILD_REVISION)"
    build_mobile_web
    pkg_to_tarfile
    echo "finish build and upload for branch $CURRENT_BRANCH"
fi


echo branch: "$TRAVIS_BRANCH", tag: "$TRAVIS_TAG"

# ignore the pull request build
if [ "$TRAVIS_PULL_REQUEST" = "true" ]; then
    exit 0
fi

if [ -n "$TRAVIS_TAG" ]; then
    echo "start build web for tag $TRAVIS_TAG"
    build_mobile_web
    pkg_to_tarfile

else
  echo "do nothing for branch $TRAVIS_BRANCH"
  exit 0
fi