import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hunde_zunder/constants/backend/api_endpoints.dart';
import 'package:hunde_zunder/models/chat_message.dart';

import 'package:hunde_zunder/models/match.dart' as Model;
import 'package:hunde_zunder/provider/pet_provider.dart';
import 'package:hunde_zunder/services/backend_service.dart';
import 'package:mutex/mutex.dart';

import '../../../../models/pet.dart';

class ChatPageProvider with ChangeNotifier {
  static final _mutex = Mutex();

  // dependencies
  PetProvider petProvider;
  BackendService backendService;

  // state
  late bool? _isSwipeeMyPet;
  late ScrollController scrollController;
  late bool initialScrolled;

  // init param
  late Model.Match match;
  void Function()? popBehavior;

  // cache
  List<ChatMessage>? _messages;

  ChatPageProvider({
    required this.petProvider,
    required this.backendService,
  }) {
    petProvider.addListener(setIsSwipeeMyPet);
  }

  void init({
    required Model.Match match,
    required Function()? popBehavior,
  }) {
    clearCache();
    this.match = match;
    this.popBehavior = popBehavior;
    scrollController = ScrollController();
    initialScrolled = false;
    setIsSwipeeMyPet();
  }

  @override
  void dispose() {
    petProvider.removeListener(setIsSwipeeMyPet);
    super.dispose();
  }

  List<ChatMessage>? get messages {
    // _messages ??= [
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHiHiHi HiHiHiHiHiHiHiHiHiHiHiHiHi HiHiHiHiHiHi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHi HiHiHiHiHiHiHi ",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message:
    //         "Hi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHiHiHi HiHiHiHiHiHiHiHiHiHiHiHiHi HiHiHiHiHiHi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHi HiHiHiHiHiHiHi ",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message:
    //         "Hi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHiHiHi HiHiHiHiHiHiHiHiHiHiHiHiHi HiHiHiHiHiHi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHi HiHiHiHiHiHiHi ",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message:
    //         "Hi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "Hi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHiHiHi HiHiHiHiHiHiHiHiHiHiHiHiHi HiHiHiHiHiHi",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message: "Hi you too",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 1,
    //     message: "HiHiHiHiHiHi HiHiHiHiHiHiHi ",
    //     timestamp: DateTime.now(),
    //   ),
    //   ChatMessage(
    //     matchID: 1,
    //     senderID: 2,
    //     message:
    //         "Hi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you tooHi you too",
    //     timestamp: DateTime.now(),
    //   ),
    // ]; // TODO backend

    if (!_mutex.isLocked && _messages == null) {
      _mutex.protect(() {
        return backendService
            .callBackend<ChatMessage>(
              requestType: RequestType.GET,
              endpoint: ApiEndpoints.allMessagesForMatch(
                match.matchID.toString(),
              ),
              jsonParser: (json) => ChatMessage.fromJson(json),
            )
            .then((messages) => _messages = messages)
            .then((_) => notifyListeners());
      });
    }

    return _messages;
  }

  void setIsSwipeeMyPet() {
    _isSwipeeMyPet = petProvider.isMyPet(match.swipeeID);
    print("_isSwipeeMyPet: $_isSwipeeMyPet");
    notifyListeners();
  }

  Future<Pet?> get myPet async {
    if (_isSwipeeMyPet == null) {
      return null;
    }
    return await petProvider.getPetByID(
      petID: _isSwipeeMyPet! ? match.swipeeID : match.swiperID,
    );
  }

  Future<Pet?> get otherPet async {
    if (_isSwipeeMyPet == null) {
      return null;
    }
    return await petProvider.getPetByID(
      petID: _isSwipeeMyPet! ? match.swiperID : match.swipeeID,
    );
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent * 1.2,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void clearCache() {
    _messages = null;
    _isSwipeeMyPet = null;
  }
}
