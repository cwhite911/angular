library angular2.transform.common.options;

import 'package:glob/glob.dart';

import 'annotation_matcher.dart';
import 'mirror_mode.dart';

const CUSTOM_ANNOTATIONS_PARAM = 'custom_annotations';
const ENTRY_POINT_PARAM = 'entry_points';
const FORMAT_CODE_PARAM = 'format_code';
const REFLECT_PROPERTIES_AS_ATTRIBUTES = 'reflect_properties_as_attributes';
const PLATFORM_DIRECTIVES = 'platform_directives';
const PLATFORM_PIPES = 'platform_pipes';
const INIT_REFLECTOR_PARAM = 'init_reflector';
const INLINE_VIEWS_PARAM = 'inline_views';
const MIRROR_MODE_PARAM = 'mirror_mode';
const LAZY_TRANSFORMERS = 'lazy_transformers';

/// Provides information necessary to transform an Angular2 app.
class TransformerOptions {
  final List<Glob> entryPointGlobs;

  /// The path to the files where the application's calls to `bootstrap` are.
  final List<String> entryPoints;

  /// The `BarbackMode#name` we are running in.
  final String modeName;

  /// The [MirrorMode] to use for the transformation.
  final MirrorMode mirrorMode;

  /// Whether to generate calls to our generated `initReflector` code
  final bool initReflector;

  /// The [AnnotationMatcher] which is used to identify angular annotations.
  final AnnotationMatcher annotationMatcher;

  /// Whether to reflect property values as attributes.
  /// If this is `true`, the change detection code will echo set property values
  /// as attributes on DOM elements, which may aid in application debugging.
  final bool reflectPropertiesAsAttributes;

  /// Whether to generate debug information in change detectors.
  /// This improves error messages when exception are triggered in templates.
  final bool genChangeDetectionDebugInfo;

  /// A set of directives that will be automatically passed-in to the template compiler
  /// Format of an item in the list:
  /// angular2/lib/src/common/common_directives.dart#COMMON_DIRECTIVES
  final List<String> platformDirectives;

  /// A set of pipes that will be automatically passed-in to the template compiler
  /// Format of an item in the list:
  /// angular2/lib/src/common/pipes.dart#COMMON_PIPES
  final List<String> platformPipes;

  /// Whether to format generated code.
  /// Code that is only modified will never be formatted because doing so may
  /// invalidate the source maps generated by `dart2js` and/or other tools.
  final bool formatCode;

  /// Whether to inline views.
  /// If this is `true`, the transformer will *only* make a single pass over the
  /// input files and inline `templateUrl` and `styleUrls` values.
  /// This is undocumented, for testing purposes only, and may change or break
  /// at any time.
  final bool inlineViews;

  /// Whether to make transformers lazy.
  /// If this is `true`, and in `debug` mode only, the transformers will be
  /// lazy (will only build assets that are requested).
  /// This is undocumented, for testing purposes only, and may change or break
  /// at any time.
  final bool lazyTransformers;

  TransformerOptions._internal(
      this.entryPoints,
      this.entryPointGlobs,
      this.modeName,
      this.mirrorMode,
      this.initReflector,
      this.annotationMatcher,
      {this.genChangeDetectionDebugInfo,
      this.reflectPropertiesAsAttributes,
      this.platformDirectives,
      this.platformPipes,
      this.inlineViews,
      this.lazyTransformers,
      this.formatCode});

  factory TransformerOptions(List<String> entryPoints,
      {String modeName: 'release',
      MirrorMode mirrorMode: MirrorMode.none,
      bool initReflector: true,
      List<ClassDescriptor> customAnnotationDescriptors: const [],
      bool inlineViews: false,
      bool genChangeDetectionDebugInfo: false,
      bool reflectPropertiesAsAttributes: false,
      List<String> platformDirectives,
      List<String> platformPipes,
      bool lazyTransformers: false,
      bool formatCode: false}) {
    var annotationMatcher = new AnnotationMatcher()
      ..addAll(customAnnotationDescriptors);
    var entryPointGlobs = entryPoints != null
        ? entryPoints.map((path) => new Glob(path)).toList(growable: false)
        : null;
    return new TransformerOptions._internal(entryPoints, entryPointGlobs,
        modeName, mirrorMode, initReflector, annotationMatcher,
        genChangeDetectionDebugInfo: genChangeDetectionDebugInfo,
        reflectPropertiesAsAttributes: reflectPropertiesAsAttributes,
        platformDirectives: platformDirectives,
        platformPipes: platformPipes,
        inlineViews: inlineViews,
        lazyTransformers: lazyTransformers,
        formatCode: formatCode);
  }
}
