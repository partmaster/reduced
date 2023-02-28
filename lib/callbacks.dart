// callbacks.dart

import 'dart:io' show HttpClient;
import 'dart:ui' show Image, Locale, Offset, Picture, Rect, VoidCallback;

import 'package:flutter/animation.dart' show Animation;
import 'package:flutter/gestures.dart'
    show
        DragEndDetails,
        DragStartDetails,
        DragUpdateDetails,
        ForcePressDetails,
        GestureRecognizer,
        LongPressEndDetails,
        LongPressMoveUpdateDetails,
        LongPressStartDetails,
        PointerCancelEvent,
        PointerDownEvent,
        PointerMoveEvent,
        PointerUpEvent,
        ScaleEndDetails,
        ScaleStartDetails,
        ScaleUpdateDetails,
        TapDownDetails,
        TapUpDetails,
        Velocity;
import 'package:flutter/rendering.dart'
    show ImageSizeInfo, Shader, TextSelection;
import 'package:flutter/services.dart'
    show
        KeyEvent,
        PlatformViewController,
        SelectionChangedCause,
        TextEditingValue;
import 'package:flutter/widgets.dart'
    show
        Action,
        AnimationStatus,
        BoxConstraints,
        BuildContext,
        DismissDirection,
        DismissUpdateDetails,
        DragDownDetails,
        DragTargetDetails,
        Draggable,
        DraggableDetails,
        Element,
        FocusNode,
        ImageChunkEvent,
        ImageInfo,
        InlineSpan,
        Intent,
        Key,
        KeyEventResult,
        NavigatorState,
        Notification,
        PlatformMenuItem,
        PlatformViewCreationParams,
        RawKeyEvent,
        Route,
        RouteSettings,
        ScrollIncrementDetails,
        ScrollNotification,
        Tween,
        TweenConstructor,
        Widget,
        visibleForTesting;
import 'package:reduced/callable.dart'
    show Callable, Callable1, Callable2, Callable3;

/// typedef ActionListenerCallback = void Function(Action<Intent> action);
typedef ActionListenerCallable = Callable1<void, Action<Intent>>;

/// typedef AnimatableCallback<T> = T Function(double);
typedef AnimatableCallable = Callable1<void, double>;

/// typedef AnimationStatusListener = void Function(AnimationStatus status);
typedef AnimationStatusListenerCallable = Callable1<void, AnimationStatus>;

/// typedef AppPrivateCommandCallback = void Function(String, Map<String, dynamic>);
typedef AppPrivateCommandCallable
    = Callable2<void, String, Map<String, dynamic>>;

/// typedef AutocompleteOnSelected<T extends Object> = void Function(T option);
typedef AutocompleteOnSelectedCallable<T extends Object> = Callable1<void, T>;

/// typedef BoxConstraintsTransform = BoxConstraints Function(BoxConstraints);
typedef BoxConstraintsTransformCallable
    = Callable1<BoxConstraints, BoxConstraints>;

/// typedef ChildIndexGetter = int? Function(Key key);
typedef ChildIndexGetterCallable = Callable1<int?, Key>;

/// typedef ConfirmDismissCallback = Future<bool?> Function(DismissDirection direction);
typedef ConfirmDismissCallable = Callable1<Future<bool?>, DismissDirection>;

/// typedef CreatePlatformViewCallback = PlatformViewController Function(PlatformViewCreationParams params);
typedef CreatePlatformViewCallable
    = Callable1<PlatformViewController, PlatformViewCreationParams>;

/// typedef CreateRectTween = Tween<Rect?> Function(Rect? begin, Rect? end);
typedef CreateRectTweenCallable = Callable2<Tween<Rect?>, Rect?, Rect?>;

/// typedef DecoderBufferCallback = Future<ui.Codec> Function(ui.ImmutableBuffer buffer, {int? cacheWidth, int? cacheHeight, bool allowUpscaling});
/// typedef DecoderBufferCallable = DecoderBufferCallback;

/// typedef DecoderCallback = Future<ui.Codec> Function(Uint8List buffer, {int? cacheWidth, int? cacheHeight, bool allowUpscaling});
/// typedef DecoderCallable = DecoderCallback;

/// typedef DismissDirectionCallback = void Function(DismissDirection direction);
typedef DismissDirectionCallable = Callable1<void, DismissDirection>;

/// typedef DismissUpdateCallback = void Function(DismissUpdateDetails details);
typedef DismissUpdateCallable = Callable1<void, DismissUpdateDetails>;

/// typedef DragAnchorStrategy = Offset Function(Draggable<Object> draggable, BuildContext context, Offset position);
typedef DragAnchorStrategyCallable
    = Callable3<Offset, Draggable<Object>, BuildContext, Offset>;

/// typedef DragEndCallback = void Function(DraggableDetails details);
typedef DragEndCallable = Callable1<void, DraggableDetails>;

/// typedef DraggableCanceledCallback = void Function(Velocity velocity, Offset offset);
typedef DraggableCanceledCallable = Callable2<void, Velocity, Offset>;

/// typedef DragSelectionUpdateCallback = void Function(DragStartDetails startDetails, DragUpdateDetails updateDetails);
typedef DragSelectionUpdateCallable
    = Callable2<void, DragStartDetails, DragUpdateDetails>;

/// typedef DragTargetAccept<T> = void Function(T data);
typedef DragTargetAcceptCallable<T> = Callable1<void, T>;

/// typedef DragTargetAcceptWithDetails<T> = void Function(DragTargetDetails<T> details);
typedef DragTargetAcceptWithDetailsCallable<T>
    = Callable1<void, DragTargetDetails<T>>;

/// typedef DragTargetLeave<T> = void Function(T? data);
typedef DragTargetLeaveCallable<T> = Callable1<void, T?>;

/// typedef DragTargetMove<T> = void Function(DragTargetDetails<T> details);
typedef DragTargetMoveCallable<T> = Callable1<void, DragTargetDetails<T>>;

/// typedef DragTargetWillAccept<T> = bool Function(T? data);
typedef DragTargetWillAcceptCallable<T> = Callable1<bool, T?>;

/// typedef DragUpdateCallback = void Function(DragUpdateDetails details);
typedef DragUpdateCallable = Callable1<void, DragUpdateDetails>;

/// typedef ElementVisitor = void Function(Element element);
typedef ElementVisitorCallable = Callable1<void, Element>;

/// typedef FocusOnKeyCallback = KeyEventResult Function(FocusNode node, RawKeyEvent event);
typedef FocusOnKeyCallable = Callable2<KeyEventResult, FocusNode, RawKeyEvent>;

/// typedef FocusOnKeyEventCallback = KeyEventResult Function(FocusNode node, KeyEvent event);
typedef FocusOnKeyEventCallable
    = Callable2<KeyEventResult, FocusNode, KeyEvent>;

/// typedef FormFieldSetter<T> = void Function(T? newValue);
typedef FormFieldSetterCallable<T> = Callable1<void, T?>;

/// typedef FormFieldValidator<T> = String? Function(T? value);
typedef FormFieldValidatorCallable<T> = Callable1<String?, T?>;

/// typedef GenerateAppTitle = String Function(BuildContext context);
typedef GenerateAppTitleCallable = Callable1<String, BuildContext>;

/// typedef GestureDragCancelCallback = void Function();
typedef GestureDragCancelCallable = Callable<void>;

/// typedef GestureDragDownCallback = void Function(DragDownDetails details);
typedef GestureDragDownCallable = Callable1<void, DragDownDetails>;

/// typedef GestureDragEndCallback = void Function(DragEndDetails details);
typedef GestureDragEndCallable = Callable1<void, DragEndDetails>;

/// typedef GestureDragStartCallback = void Function(DragStartDetails details);
typedef GestureDragStartCallable = Callable1<void, DragStartDetails>;

/// typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
typedef GestureDragUpdateCallable = Callable1<void, DragUpdateDetails>;

/// typedef GestureForcePressEndCallback = void Function(ForcePressDetails details);
typedef GestureForcePressEndCallable = Callable1<void, ForcePressDetails>;

/// typedef GestureForcePressPeakCallback = void Function(ForcePressDetails details);
typedef GestureForcePressPeakCallable = Callable1<void, ForcePressDetails>;

/// typedef GestureForcePressStartCallback = void Function(ForcePressDetails details);
typedef GestureForcePressStartCallable = Callable1<void, ForcePressDetails>;

/// typedef GestureForcePressUpdateCallback = void Function(ForcePressDetails details);
typedef GestureForcePressUpdateCallable = Callable1<void, ForcePressDetails>;

/// typedef GestureLongPressCallback = void Function();
typedef GestureLongPressCallable = Callable<void>;

/// typedef GestureLongPressEndCallback = void Function(LongPressEndDetails details);
typedef GestureLongPressEndCallable = Callable1<void, LongPressEndDetails>;

/// typedef GestureLongPressMoveUpdateCallback = void Function(LongPressMoveUpdateDetails details);
typedef GestureLongPressMoveUpdateCallable
    = Callable1<void, LongPressMoveUpdateDetails>;

/// typedef GestureLongPressStartCallback = void Function(LongPressStartDetails details);
typedef GestureLongPressStartCallable = Callable1<void, LongPressStartDetails>;

/// typedef GestureLongPressUpCallback = void Function();
typedef GestureLongPressUpCallable = Callable<void>;

/// typedef GestureRecognizerFactoryConstructor<T extends GestureRecognizer> = T Function();
typedef GestureRecognizerFactoryConstructorCallable<T extends GestureRecognizer>
    = Callable<T>;

/// typedef GestureRecognizerFactoryInitializer<T extends GestureRecognizer> = void Function(T instance);
typedef GestureRecognizerFactoryInitializerCallable<T extends GestureRecognizer>
    = Callable1<void, T>;

/// typedef GestureScaleEndCallback = void Function(ScaleEndDetails details);
typedef GestureScaleEndCallable = Callable1<void, ScaleEndDetails>;

/// typedef GestureScaleStartCallback = void Function(ScaleStartDetails details);
typedef GestureScaleStartCallable = Callable1<void, ScaleStartDetails>;

/// typedef GestureScaleUpdateCallback = void Function(ScaleUpdateDetails details);
typedef GestureScaleUpdateCallable = Callable1<void, ScaleUpdateDetails>;

/// typedef GestureTapCallback = void Function();
typedef GestureTapCallable = Callable<void>;

/// typedef GestureTapCancelCallback = void Function();
typedef GestureTapCancelCallable = Callable<void>;

/// typedef GestureTapDownCallback = void Function(TapDownDetails details);
typedef GestureTapDownCallable = Callable1<void, TapDownDetails>;

/// typedef GestureTapUpCallback = void Function(TapUpDetails details);
typedef GestureTapUpCallable = Callable1<void, TapUpDetails>;

/// typedef HttpClientProvider = HttpClient Function();
typedef HttpClientProviderCallable = Callable<HttpClient>;

/// typedef ImageChunkListener = void Function(ImageChunkEvent event);
typedef ImageChunkListenerCallable = Callable1<void, ImageChunkEvent>;

/// typedef ImageErrorListener = void Function(Object exception, StackTrace? stackTrace);
typedef ImageErrorListenerCallable = Callable2<void, Object, StackTrace?>;

/// typedef ImageListener = void Function(ImageInfo image, bool synchronousCall);
typedef ImageListenerCallable = Callable2<void, ImageInfo, bool>;

/// typedef InitialRouteListFactory = List<Route<dynamic>> Function(String initialRoute);
typedef InitialRouteListFactoryCallable
    = Callable1<List<Route<dynamic>>, String>;

/// typedef InlineSpanVisitor = bool Function(InlineSpan span);
typedef InlineSpanVisitorCallable = Callable1<bool, InlineSpan>;

/// typedef InspectorSelectionChangedCallback = void Function();
typedef InspectorSelectionChangedCallable = Callable<void>;

/// typedef LocaleListResolutionCallback = Locale? Function(List<Locale>? locales, Iterable<Locale> supportedLocales);
typedef LocaleListResolutionCallable
    = Callable2<Locale?, List<Locale>?, Iterable<Locale>>;

/// typedef LocaleResolutionCallback = Locale? Function(Locale? locale, Iterable<Locale> supportedLocales);
typedef LocaleResolutionCallable
    = Callable2<Locale?, Locale?, Iterable<Locale>>;

/// typedef MenuItemSerializableIdGenerator = int Function(PlatformMenuItem item);
typedef MenuItemSerializableIdGeneratorCallable
    = Callable1<int, PlatformMenuItem>;

/// typedef NavigatorFinderCallback = NavigatorState Function(BuildContext context);
typedef NavigatorFinderCallable = Callable1<NavigatorState, BuildContext>;

/// typedef NotificationListenerCallback<T extends Notification> = bool Function(T notification);
typedef NotificationListenerCallable<T extends Notification>
    = Callable1<bool, T>;

/// typedef OnInvokeCallback<T extends Intent> = Object? Function(T intent);
typedef OnInvokeCallable<T extends Intent> = Callable1<Object?, T>;

/// typedef PageRouteFactory = PageRoute<T> Function<T>(RouteSettings settings, WidgetBuilder builder);
/// typedef PageRouteFactoryCallable = PageRouteFactory;

/// typedef PaintImageCallback = void Function(ImageSizeInfo);
typedef PaintImageCallable = Callable1<void, ImageSizeInfo>;

/// typedef PlatformViewSurfaceFactory = Widget Function(BuildContext context, PlatformViewController controller);
typedef PlatformViewSurfaceFactoryCallable
    = Callable2<Widget, BuildContext, PlatformViewController>;

/// typedef PointerCancelEventListener = void Function(PointerCancelEvent event);
typedef PointerCancelEventListenerCallable
    = Callable1<void, PointerCancelEvent>;

/// typedef PointerDownEventListener = void Function(PointerDownEvent event);
typedef PointerDownEventListenerCallable = Callable1<void, PointerDownEvent>;

/// typedef PointerMoveEventListener = void Function(PointerMoveEvent event);
typedef PointerMoveEventListenerCallable = Callable1<void, PointerMoveEvent>;

/// typedef PointerUpEventListener = void Function(PointerUpEvent event);
typedef PointerUpEventListenerCallable = Callable1<void, PointerUpEvent>;

/// typedef PopPageCallback = bool Function(Route<dynamic> route, dynamic result);
typedef PopPageCallable = Callable2<bool, Route<dynamic>, dynamic>;

/// typedef RebuildDirtyWidgetCallback = void Function(Element e, bool builtOnce);
typedef RebuildDirtyWidgetCallable = Callable2<void, Element, bool>;

/// typedef RegisterServiceExtensionCallback = void Function({required String name, required ServiceExtensionCallback callback,});
/// typedef RegisterServiceExtensionCallable = RegisterServiceExtensionCallback;

/// typedef ReorderCallback = void Function(int oldIndex, int newIndex);
typedef ReorderCallable = Callable2<void, int, int>;

/// typedef ReorderItemProxyDecorator = Widget Function(Widget child, int index, Animation<double> animation);
typedef ReorderItemProxyDecoratorCallable
    = Callable3<Widget, Widget, int, Animation<double>>;

/// typedef RouteCompletionCallback<T> = void Function(T result);
typedef RouteCompletionCallable<T> = Callable1<void, T>;

/// typedef RouteFactory = Route<dynamic>? Function(RouteSettings settings);
typedef RouteFactoryCallable = Callable1<Route<dynamic>?, RouteSettings>;

/// typedef RouteListFactory = List<Route<dynamic>> Function(NavigatorState navigator, String initialRoute);
typedef RouteListFactoryCallable
    = Callable2<List<Route<dynamic>>, NavigatorState, String>;

/// typedef RoutePredicate = bool Function(Route<dynamic> route);
typedef RoutePredicateCallable = Callable1<bool, Route<dynamic>>;

/// typedef RoutePresentationCallback = String Function(NavigatorState navigator, Object? arguments);
typedef RoutePresentationCallable = Callable2<String, NavigatorState, Object?>;

/// typedef ScrollIncrementCalculator = double Function(ScrollIncrementDetails details);
typedef ScrollIncrementCalculatorCallable
    = Callable1<double, ScrollIncrementDetails>;

/// typedef ScrollNotificationCallback = void Function(ScrollNotification notification);
typedef ScrollNotificationCallable = Callable1<void, ScrollNotification>;

/// typedef ScrollNotificationPredicate = bool Function(ScrollNotification notification);
typedef ScrollNotificationPredicateCallable
    = Callable1<bool, ScrollNotification>;

/// typedef SelectionChangedCallback = void Function(TextSelection selection, SelectionChangedCause? cause);
typedef SelectionChangedCallable
    = Callable2<void, TextSelection, SelectionChangedCause?>;

/// typedef SemanticIndexCallback = int? Function(Widget widget, int localIndex);
typedef SemanticIndexCallable = Callable2<int?, Widget, int>;

/// typedef ShaderCallback = Shader Function(Rect bounds);
typedef ShaderCallable = Callable1<Shader, Rect>;

/// typedef ShaderWarmUpImageCallback = bool Function(Image);
typedef ShaderWarmUpImageCallable = Callable1<bool, Image>;

/// typedef ShaderWarmUpPictureCallback = bool Function(Picture);
typedef ShaderWarmUpPictureCallable = Callable1<bool, Picture>;

/// typedef SharedAppDataInitCallback<T> = T Function();
typedef SharedAppDataInitCallable<T> = Callable<T>;

/// typedef StateSetter = void Function(VoidCallback fn);
typedef StateSetterCallable = Callable1<void, VoidCallback>;

/// typedef TapRegionCallback = void Function(PointerDownEvent event);
typedef TapRegionCallable = Callable1<void, PointerDownEvent>;

/// typedef TextEditingValueCallback = void Function(TextEditingValue value);
@visibleForTesting
typedef TextEditingValueCallable = Callable1<void, TextEditingValue>;

/// typedef TweenConstructor<T extends Object> = Tween<T> Function(T targetValue);
typedef TweenConstructorCallable<T extends Object> = Callable1<Tween<T>, T>;

/// typedef TweenVisitor<T extends Object> = Tween<T>? Function(Tween<T>? tween, T targetValue, TweenConstructor<T> constructor);
typedef TweenVisitorCallable<T extends Object>
    = Callable3<Tween<T>?, Tween<T>?, T, TweenConstructor<T>>;

/// typedef ValueChanged<T> = void Function(T value);
typedef ValueChangedCallable<T> = Callable1<void, T>;

/// typedef ValueGetter<T> = T Function();
typedef ValueGetterCallable<T> = Callable<T>;

/// typedef ValueListenableTransformer<T> = T Function(T);
typedef ValueListenableTransformerCallable<T> = Callable1<T, T>;

/// typedef ValueSetter<T> = void Function(T value);
typedef ValueSetterCallable<T> = Callable1<void, T>;

/// typedef VoidCallback = void Function();
typedef VoidCallable = Callable<void>;

/// typedef WillPopCallback = Future<bool> Function();
typedef WillPopCallable = Callable<Future<bool>>;
