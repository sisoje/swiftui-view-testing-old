cd HostApp
git clean -fdx
mise install tuist@4.20.0
mise use tuist@4.20.0
tuist generate --no-open
xcodebuild \
  -project HostApp.xcodeproj \
  -scheme HostApp \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  test
