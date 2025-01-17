# ai_one_flutter

ai one Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our。
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# ai-ones-flutter

# json_model

pub run json_model src=jsons dist=models/xxx

# retrofit(因为依赖了json_model，所以在生成代码过程中也会对json_serializable标记的@JsonSerializable()类重新生成)

dependencies
retrofit: ^1.3.4
logger: ^0.9.1
dev_dependencies:
build_runner: ^1.4.0
retrofit_generator: any

# drift数据库组件代码生成

flutter pub run build_runner build

# moor数据库

flutter packages pub run build_runner build --delete-conflicting-outputs

# android run (在idea中需要配置Build flavor为dev，不然无法安装调试)
flutter run --flavor dev -t lib/main.dart

# web run

flutter run -d chrome --release --web-port=55140 //
release在指定端口下运行，且此时可以访问在web/assets目录下未在pubspec.yaml申明的资源（手动拷贝到此目录的文件）;

# 国际化资源生成
dart run intl_translation:extract_to_arb --output-dir=lib/l10n/arb lib/l10n/intl_messages.dart

dart run intl_translation:generate_from_arb --output-dir=lib/l10n/languages --no-use-deferred-loading lib/l10n/intl_messages.dart lib/l10n/arb/intl_*.arb
