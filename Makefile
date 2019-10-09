.PHONY: xcodeproj
xcodeproj:
	pushd swift; swift package generate-xcodeproj; popd;
