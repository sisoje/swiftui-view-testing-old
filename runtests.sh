cd HostApp
git clean -fdx
mise install tuist@4.20.0
mise use tuist@4.20.0
touch Tests.swift
echo "import ViewTestingProd; @main extension ViewTestingApp {}" > App.swift
tuist generate --no-open
xcodebuild \
  -project HostApp.xcodeproj \
  -scheme HostApp \
  test
