import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_status.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_share_action.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_share_statistic_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_video_statistic_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_video_status.dart';

/// Zoom Video SDK User
class ZoomVideoSdkUser {
  final String userId;

  /// the identify of the user
  final String customUserId;

  /// the custom identify of the user
  final String userName;

  /// the name of the user
  final bool isHost;

  /// true: if the user is the host of the session
  final bool isManager;

  /// true: if the user is the manager of the session
  final bool isSharing;

  /// true: if the user is sharing
  final bool isVideoSpotLighted;

  /// true: if the user is video spot lighted
  final bool? hasMultiCamera;

  /// true: if the user has multiple cameras
  final String? multiCameraIndex;

  /// the index of the multiple cameras
  final ZoomVideoSdkAudioStatus? audioStatus;

  /// the audio status of the user
  final ZoomVideoSdkVideoStatus? videoStatus;

  /// the video status of the user
  final ZoomVideoSdkVideoStatisticInfo? videoStatisticInfo;

  /// the video statistic information of the user
  final ZoomVideoSdkShareStatisticInfo? shareStatisticInfo;

  /// the share statistic information of the user

  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  const ZoomVideoSdkUser(
    this.userId,
    this.customUserId,
    this.userName,
    this.isHost,
    this.isManager,
    this.isVideoSpotLighted,
    this.hasMultiCamera,
    this.multiCameraIndex,
    this.isSharing, {
    this.audioStatus,
    this.videoStatus,
    this.videoStatisticInfo,
    this.shareStatisticInfo,
  });

  ZoomVideoSdkUser copyWith({
    String? userId,
    String? customUserId,
    String? userName,
    bool? isHost,
    bool? isManager,
    bool? isVideoSpotLighted,
    bool? hasMultiCamera,
    String? multiCameraIndex,
    ZoomVideoSdkAudioStatus? audioStatus,
    ZoomVideoSdkVideoStatus? videoStatus,
    ZoomVideoSdkVideoStatisticInfo? videoStatisticInfo,
    ZoomVideoSdkShareStatisticInfo? shareStatisticInfo,
    bool? isSharing,
  }) => ZoomVideoSdkUser(
    userId ?? this.userId,
    customUserId ?? this.customUserId,
    userName ?? this.userName,
    isHost ?? this.isHost,

    isManager ?? this.isManager,
    isVideoSpotLighted ?? this.isVideoSpotLighted,

    hasMultiCamera ?? this.hasMultiCamera,
    multiCameraIndex ?? this.multiCameraIndex,
    isSharing ?? this.isSharing,
    audioStatus: audioStatus ?? this.audioStatus,
    videoStatus: videoStatus ?? this.videoStatus,
    videoStatisticInfo: videoStatisticInfo ?? this.videoStatisticInfo,
    shareStatisticInfo: shareStatisticInfo ?? this.shareStatisticInfo,
  );

  ZoomVideoSdkUser.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
      customUserId = json['customUserId'],
      userName = json['userName'],
      isHost = json['isHost'],
      isManager = json['isManager'],
      isVideoSpotLighted = json['isVideoSpotLighted'],
      isSharing = false,
      hasMultiCamera = json['hasMultiCamera'],
      multiCameraIndex = json['multiCameraIndex'],
      audioStatus = ZoomVideoSdkAudioStatus(json['userId']),
      videoStatus = ZoomVideoSdkVideoStatus(json['userId']),
      videoStatisticInfo = ZoomVideoSdkVideoStatisticInfo(json['userId']),
      shareStatisticInfo = ZoomVideoSdkShareStatisticInfo(json['userId']);

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'customUserId': customUserId,
    'userName': userName,
    'isHost': isHost,
    'isManager': isManager,
    'isVideoSpotLighted': isVideoSpotLighted,
    'hasMultiCamera': hasMultiCamera,
    'multiCameraIndex': multiCameraIndex,
  };

  /// Get the name of the user in the session.
  /// <br />Return the name of the user in the session.
  Future<String> getUserName() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel.invokeMethod<String>('getUserName', params).then<String>((String? value) => value ?? "");
  }

  /// Get the user's screen share status.
  /// <br />Return the share status of the user in the session.
  @Deprecated('Use getShareActionList instead.')
  Future<String> getShareStatus() async {
    return "";
  }

  Future<List<ZoomVideoSdkShareAction>?> getShareActionList() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    var shareActionListString = await methodChannel
        .invokeMethod<String?>('getShareActionList', params)
        .then<String?>((String? value) => value);

    var shareActionListJson = jsonDecode(shareActionListString!) as List;
    List<ZoomVideoSdkShareAction> shareActionList = shareActionListJson
        .map((shareActionJson) => ZoomVideoSdkShareAction.fromJson(shareActionJson))
        .toList();

    return shareActionList;
  }

  /// Determine whether the user is the host.
  /// <br />Return true indicates that the user is the host, otherwise false.
  Future<bool> getIsHost() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel.invokeMethod<bool>('isHost', params).then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the user is the manager.
  /// <br />Return true indicates that the user is the manager, otherwise false.
  Future<bool> getIsManager() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel.invokeMethod<bool>('isManager', params).then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the user's video is spotlighted.
  /// <br />Return true indicates that the user's video is spotlighted, otherwise false.
  Future<bool> getIsVideoSpotLighted() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('isVideoSpotLighted', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Set the user's local volume. This does not affect how other participants hear the user.
  /// <br />[userId] the identify of the user
  /// <br />[volume] the volume of the user
  /// <br />[isShareAudio] true: if the user is sharing audio, otherwise false
  /// <br />Return true the methods succeeds, otherwise false.
  Future<bool> setUserVolume(String userId, num volume, bool isShareAudio) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("volume", () => volume);
    params.putIfAbsent("isShareAudio", () => isShareAudio);

    return await methodChannel.invokeMethod<bool>('setUserVolume', params).then<bool>((bool? value) => value ?? false);
  }

  /// Get user volume.
  /// <br />[userId] the identify of the user
  /// <br />[isShareAudio] true: if the user is sharing audio, otherwise false
  /// <br />Return user volume.
  Future<num> getUserVolume(String userId, bool isShareAudio) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("isShareAudio", () => isShareAudio);

    return await methodChannel.invokeMethod<num>('getUserVolume', params).then<num>((num? value) => value ?? -1);
  }

  /// Determine which audio you can set, shared audio or microphone.
  /// <br />[userId] the identify of the user
  /// <br />[isShareAudio] true: if the user is sharing audio, otherwise false
  /// <br />Return true if can set user volume, otherwise false
  Future<bool> canSetUserVolume(String userId, bool isShareAudio) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("isShareAudio", () => isShareAudio);

    return await methodChannel
        .invokeMethod<bool>('canSetUserVolume', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get the GUID of the user in the session.
  /// <br />Return the GUID of the user in the session.
  Future<String> getUserReference() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('getUserReference', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the network status by dataType of the user in the session.
  /// <br />Return the network status of the user in the session.
  Future<String> getNetworkLevel(String dataType) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("dataType", () => dataType);

    return await methodChannel
        .invokeMethod<String>('getNetworkLevel', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the overall network status of the user in the session.
  /// <br />Return the overall network status of the user in the session.
  Future<String> getOverallNetworkLevel() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('getOverallNetworkLevel', params)
        .then<String>((String? value) => value ?? "");
  }
}
