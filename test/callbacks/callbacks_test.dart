// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/callbacks.dart';

void main() {
  test('Callable typedefs assignable test', () {
    final r = Random().nextInt(1);
    if (r < 2) {
      return;
    }
    final callable = Object();

    final ActionListenerCallback actionListenerCallback =
        callable as ActionListenerCallable;
// CHECK check flutter version
//    final AnimatableCallback animatableCallback =
//        callable as AnimatableCallable;
    final AnimationStatusListener animationStatusListener =
        callable as AnimationStatusListenerCallable;
    final AppPrivateCommandCallback appPrivateCommandCallback =
        callable as AppPrivateCommandCallable;
    final AutocompleteOnSelected<String> autocompleteOnSelected =
        callable as AutocompleteOnSelectedCallable<String>;
    final BoxConstraintsTransform boxConstraintsTransform =
        callable as BoxConstraintsTransformCallable;
    final ChildIndexGetter childIndexGetter =
        callable as ChildIndexGetterCallable;
    final ConfirmDismissCallback confirmDismissCallback =
        callable as ConfirmDismissCallable;
    final CreatePlatformViewCallback createPlatformViewCallback =
        callable as CreatePlatformViewCallable;
    final CreateRectTween createRectTween = callable as CreateRectTweenCallable;
// final DecoderBufferCallback decoderBufferCallback = callable as DecoderBufferCallable;
// final DecoderCallback decoderCallback = callable as DecoderCallable;
    final DismissDirectionCallback dismissDirectionCallback =
        callable as DismissDirectionCallable;
    final DismissUpdateCallback dismissUpdateCallback =
        callable as DismissUpdateCallable;
    final DragAnchorStrategy dragAnchorStrategy =
        callable as DragAnchorStrategyCallable;
    final DragEndCallback dragEndCallback = callable as DragEndCallable;
    final DraggableCanceledCallback draggableCanceledCallback =
        callable as DraggableCanceledCallable;
    final DragSelectionUpdateCallback dragSelectionUpdateCallback =
        callable as DragSelectionUpdateCallable;
    final DragTargetAccept<String> dragTargetAccept =
        callable as DragTargetAcceptCallable<String>;
    final DragTargetAcceptWithDetails<Object> dragTargetAcceptWithDetails =
        callable as DragTargetAcceptWithDetailsCallable<Object>;
    final DragTargetLeave<String> dragTargetLeave =
        callable as DragTargetLeaveCallable<String>;
    final DragTargetMove<Object> dragTargetMove =
        callable as DragTargetMoveCallable<Object>;
    final DragTargetWillAccept<Object> dragTargetWillAccept =
        callable as DragTargetWillAcceptCallable<Object>;
    final DragUpdateCallback dragUpdateCallback =
        callable as DragUpdateCallable;
    final ElementVisitor elementVisitor = callable as ElementVisitorCallable;
    final FocusOnKeyCallback focusOnKeyCallback =
        callable as FocusOnKeyCallable;
    final FocusOnKeyEventCallback focusOnKeyEventCallback =
        callable as FocusOnKeyEventCallable;
    final FormFieldSetter<String> formFieldSetter =
        callable as FormFieldSetterCallable<String>;
    final FormFieldValidator<Object> formFieldValidator =
        callable as FormFieldValidatorCallable<Object>;
    final GenerateAppTitle generateAppTitle =
        callable as GenerateAppTitleCallable;
    final GestureDragCancelCallback gestureDragCancelCallback =
        callable as GestureDragCancelCallable;
    final GestureDragDownCallback gestureDragDownCallback =
        callable as GestureDragDownCallable;
    final GestureDragEndCallback gestureDragEndCallback =
        callable as GestureDragEndCallable;
    final GestureDragStartCallback gestureDragStartCallback =
        callable as GestureDragStartCallable;
    final GestureDragUpdateCallback gestureDragUpdateCallback =
        callable as GestureDragUpdateCallable;
    final GestureForcePressEndCallback gestureForcePressEndCallback =
        callable as GestureForcePressEndCallable;
    final GestureForcePressPeakCallback gestureForcePressPeakCallback =
        callable as GestureForcePressPeakCallable;
    final GestureForcePressStartCallback gestureForcePressStartCallback =
        callable as GestureForcePressStartCallable;
    final GestureForcePressUpdateCallback gestureForcePressUpdateCallback =
        callable as GestureForcePressUpdateCallable;
    final GestureLongPressCallback gestureLongPressCallback =
        callable as GestureLongPressCallable;
    final GestureLongPressEndCallback gestureLongPressEndCallback =
        callable as GestureLongPressEndCallable;
    final GestureLongPressMoveUpdateCallback
        gestureLongPressMoveUpdateCallback =
        callable as GestureLongPressMoveUpdateCallable;
    final GestureLongPressStartCallback gestureLongPressStartCallback =
        callable as GestureLongPressStartCallable;
    final GestureLongPressUpCallback gestureLongPressUpCallback =
        callable as GestureLongPressUpCallable;
    final GestureRecognizerFactoryConstructor<GestureRecognizer>
        gestureRecognizerFactoryConstructor =
        callable as GestureRecognizerFactoryConstructor<GestureRecognizer>;
    final GestureRecognizerFactoryInitializer<GestureRecognizer>
        gestureRecognizerFactoryInitializer =
        callable as GestureRecognizerFactoryInitializer<GestureRecognizer>;
    final GestureScaleEndCallback gestureScaleEndCallback =
        callable as GestureScaleEndCallable;
    final GestureScaleStartCallback gestureScaleStartCallback =
        callable as GestureScaleStartCallable;
    final GestureScaleUpdateCallback gestureScaleUpdateCallback =
        callable as GestureScaleUpdateCallable;
    final GestureTapCallback gestureTapCallback =
        callable as GestureTapCallable;
    final GestureTapCancelCallback gestureTapCancelCallback =
        callable as GestureTapCancelCallable;
    final GestureTapDownCallback gestureTapDownCallback =
        callable as GestureTapDownCallable;
    final GestureTapUpCallback gestureTapUpCallback =
        callable as GestureTapUpCallable;
    final ImageChunkListener imageChunkListener =
        callable as ImageChunkListenerCallable;
    final ImageErrorListener imageErrorListener =
        callable as ImageErrorListenerCallable;
    final ImageListener imageListener = callable as ImageListenerCallable;
    final InitialRouteListFactory initialRouteListFactory =
        callable as InitialRouteListFactoryCallable;
    final InlineSpanVisitor inlineSpanVisitor =
        callable as InlineSpanVisitorCallable;
    final InspectorSelectionChangedCallback inspectorSelectionChangedCallback =
        callable as InspectorSelectionChangedCallable;
    final LocaleListResolutionCallback localeListResolutionCallback =
        callable as LocaleListResolutionCallable;
    final LocaleResolutionCallback localeResolutionCallback =
        callable as LocaleResolutionCallable;
// CHECK check flutter version
//    final MenuItemSerializableIdGenerator menuItemSerializableIdGenerator =
//        callable as MenuItemSerializableIdGeneratorCallable;
    final NavigatorFinderCallback navigatorFinderCallback =
        callable as NavigatorFinderCallable;
    final NotificationListenerCallback notificationListenerCallback =
        callable as NotificationListenerCallback<Notification>;
    final OnInvokeCallback<ActivateIntent> onInvokeCallback =
        callable as OnInvokeCallback<ActivateIntent>;
// final PageRouteFactory pageRouteFactory = callable as PageRouteFactoryCallable;
    final PaintImageCallback paintImageCallback =
        callable as PaintImageCallable;
    final PlatformViewSurfaceFactory platformViewSurfaceFactory =
        callable as PlatformViewSurfaceFactoryCallable;
    final PointerCancelEventListener pointerCancelEventListener =
        callable as PointerCancelEventListenerCallable;
    final PointerDownEventListener pointerDownEventListener =
        callable as PointerDownEventListenerCallable;
    final PointerMoveEventListener pointerMoveEventListener =
        callable as PointerMoveEventListenerCallable;
    final PointerUpEventListener pointerUpEventListener =
        callable as PointerUpEventListenerCallable;
    final PopPageCallback popPageCallback = callable as PopPageCallable;
    final RebuildDirtyWidgetCallback rebuildDirtyWidgetCallback =
        callable as RebuildDirtyWidgetCallable;
// final RegisterServiceExtensionCallback registerServiceExtensionCallback = callable as RegisterServiceExtensionCallable;
    final ReorderCallback reorderCallback = callable as ReorderCallable;
    final ReorderItemProxyDecorator reorderItemProxyDecorator =
        callable as ReorderItemProxyDecoratorCallable;
    final RouteCompletionCallback<String> routeCompletionCallback =
        callable as RouteCompletionCallable<String>;
    final RouteFactory routeFactory = callable as RouteFactoryCallable;
    final RouteListFactory routeListFactory =
        callable as RouteListFactoryCallable;
    final RoutePredicate routePredicate = callable as RoutePredicateCallable;
    final RoutePresentationCallback routePresentationCallback =
        callable as RoutePresentationCallable;
    final ScrollIncrementCalculator scrollIncrementCalculator =
        callable as ScrollIncrementCalculator;
    final ScrollNotificationCallback scrollNotificationCallback =
        callable as ScrollNotificationCallable;
    final ScrollNotificationPredicate scrollNotificationPredicate =
        callable as ScrollNotificationPredicateCallable;
    final SelectionChangedCallback selectionChangedCallback =
        callable as SelectionChangedCallable;
    final SemanticIndexCallback semanticIndexCallback =
        callable as SemanticIndexCallable;
    final ShaderCallback shaderCallback = callable as ShaderCallable;
    final ShaderWarmUpImageCallback shaderWarmUpImageCallback =
        callable as ShaderWarmUpImageCallable;
    final ShaderWarmUpPictureCallback shaderWarmUpPictureCallback =
        callable as ShaderWarmUpPictureCallable;
    final SharedAppDataInitCallback<Object> sharedAppDataInitCallback =
        callable as SharedAppDataInitCallable<Object>;
    final StateSetter stateSetter = callable as StateSetterCallable;
// CHECK check flutter version
//    final TapRegionCallback tapRegionCallback = callable as TapRegionCallable;
    final TextEditingValueCallback textEditingValueCallback =
        callable as TextEditingValueCallable;
    final TweenConstructor<String> tweenConstructor =
        callable as TweenConstructorCallable<String>;
    final TweenVisitor tweenVisitor = callable as TweenVisitorCallable;
    final ValueChanged<String> valueChanged =
        callable as ValueChangedCallable<String>;
    final ValueGetter<Object> valueGetter =
        callable as ValueGetterCallable<Object>;
// CHECK check flutter version
//    final ValueListenableTransformer<Object> valueListenableTransformer =
//        callable as ValueListenableTransformerCallable<Object>;
    final ValueSetter<String> valueSetter =
        callable as ValueSetterCallable<String>;
    final VoidCallback voidCallback = callable as VoidCallable;
    final WillPopCallback willPopCallback = callable as WillPopCallable;
  });
}
