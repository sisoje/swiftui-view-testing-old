cd HostApp
git clean -fdx
tuist generate --no-open
xcodebuild \
  -project HostApp.xcodeproj \
  -scheme HostApp \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  test
  