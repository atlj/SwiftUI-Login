if swift-format format --recursive --in-place --configuration ./swiftFormatConfig.json .; then
  echo ✅ Successfully formatted
else
  echo ❌ Couldn\'t format file
fi
