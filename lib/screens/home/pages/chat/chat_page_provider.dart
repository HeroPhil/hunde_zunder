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
  late TextEditingController textEditingController;

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
    textEditingController = TextEditingController();
    setIsSwipeeMyPet();
  }

  @override
  void dispose() {
    petProvider.removeListener(setIsSwipeeMyPet);
    super.dispose();
  }

  List<ChatMessage>? get messages {
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
      scrollController.position.maxScrollExtent * 1.2 + 100,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future sendMessage() async {
    // Great Message
    final message = ChatMessage(
      matchID: match.matchID,
      message: textEditingController.text,
      senderID: (await myPet)!.petID,
      timestamp: DateTime.now(),
    );

    // optimistic update
    _messages?.add(message);

    // send to backend
    await backendService.callBackend<ChatMessage>(
      requestType: RequestType.POST,
      endpoint: ApiEndpoints.sendMessage(
        message.matchID.toString(),
      ),
      body: message.toJson,
    );

    // reset text field
    textEditingController.clear();

    // notify listeners
    notifyListeners();

    // scroll to bottom
    scrollToBottom();
  }

  void clearCache() {
    _messages = null;
    _isSwipeeMyPet = null;
  }
}
