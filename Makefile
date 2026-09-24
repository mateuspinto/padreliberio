SHELL := /bin/bash

PORT := 8080
PHONE_IP := 192.168.3.101

# Set TEST=1 to use always-live test YouTube channels (Lofi Girl) instead of
# the real Missa/Padre channels for Início's live-detection — lets you check
# that screen without waiting for an actual broadcast. See the channel ids
# and the priority logic in lib/core/live_priority.dart.
TEST ?=
DART_DEFINES := $(if $(TEST),--dart-define=USE_TEST_CHANNELS=true,)

.PHONY: web android dandroid

# CanvasKit only. Skwasm's multithreading requires Cross-Origin-Opener-Policy/
# Cross-Origin-Embedder-Policy headers, which break the embedded camera
# <iframe> (safecam.brsuper.com.br) — see CameraSection. Not worth the
# tradeoff for an app that isn't graphics-heavy.
web:
	flutter pub get
	flutter run -d web-server --release --web-hostname localhost --web-port $(PORT)

# Wireless debugging's port is ephemeral — Android regenerates it whenever
# the toggle cycles, even with a fixed IP — so rediscover it via mDNS on
# every run instead of hardcoding it. Prints the resulting adb serial.
define find_phone
for candidate in $$(adb mdns services 2>/dev/null | grep _adb-tls-connect._tcp | grep -oE '$(PHONE_IP):[0-9]+' | sort -u); do \
	adb connect "$$candidate" >/dev/null 2>&1; \
done; \
phone=$$(adb devices 2>/dev/null | grep '^$(PHONE_IP):' | grep -w device | awk '{print $$1}' | head -1); \
if [ -z "$$phone" ]; then \
	echo "Phone not in Wi-Fi debugging" >&2; \
	exit 1; \
fi; \
echo "$$phone"
endef

# Release APK, split per ABI (smaller per-device download than a universal
# APK), R8 minify + resource shrink on, installed straight to the Poco F5.
# Still signed with the debug keystore (android/app/build.gradle.kts) — fine
# for sideloading on your own device, not for store distribution.
android:
	flutter pub get
	flutter build apk --release --split-per-abi $(DART_DEFINES)
	phone=$$($(find_phone)) && adb -s "$$phone" install -r build/app/outputs/flutter-apk/app-arm64-v8a-release.apk

# Debug session (hot reload) on the Poco F5 over Wi-Fi debugging.
dandroid:
	flutter pub get
	phone=$$($(find_phone)) && flutter run -d "$$phone" $(DART_DEFINES)
