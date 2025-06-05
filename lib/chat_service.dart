import 'package:flutter/material.dart';

class ChatMessage {
  final String id;
  final String message;
  final bool isFromPT;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isFromPT,
    required this.timestamp,
  });
}

class ChatData {
  final String ptId;
  final String ptName;
  final String ptImage;
  final List<ChatMessage> messages;

  ChatData({
    required this.ptId,
    required this.ptName,
    required this.ptImage,
    required this.messages,
  });

  String get lastMessage {
    if (messages.isEmpty) return "No messages yet";
    return messages.last.message;
  }

  DateTime get lastMessageTime {
    if (messages.isEmpty) return DateTime.now();
    return messages.last.timestamp;
  }
}

class ChatService extends ChangeNotifier {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final List<ChatData> _chats = [];

  List<ChatData> get chats => _chats;

  ChatData? getChatByPtId(String ptId) {
    try {
      return _chats.firstWhere((chat) => chat.ptId == ptId);
    } catch (e) {
      return null;
    }
  }

  void addMessage(String ptId, String message, bool isFromPT) {
    final chatIndex = _chats.indexWhere((chat) => chat.ptId == ptId);
    if (chatIndex != -1) {
      _chats[chatIndex].messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              message: message,
              isFromPT: isFromPT,
              timestamp: DateTime.now(),
            ),
          );
      notifyListeners();
    }
  }

  void createNewChat(String ptId, String ptName, String ptImage) {
    final existingChat = getChatByPtId(ptId);
    if (existingChat == null) {
      _chats.add(
        ChatData(
          ptId: ptId,
          ptName: ptName,
          ptImage: ptImage,
          messages: [],
        ),
      );
      notifyListeners();
    }
  }
}
