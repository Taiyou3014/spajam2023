import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> makeQuestion(String inputMessage) async {
  await dotenv.load(fileName: '.env');
  OpenAI.apiKey = dotenv.get('OPEN_AI_API_KEY');

  final response = await getChatGptResponse(inputMessage);
  return response;
}

Future<String> getChatGptResponse(String message) async {
  final messages = [
    const OpenAIChatCompletionChoiceMessageModel(
      content:'あなたは提示された都道府県の、特産品、社会問題、主な特徴をお答えください。\n各項目1行以内で、その都道府県の名前を入れないでください。',
      role: OpenAIChatMessageRole.system,
    ),
    OpenAIChatCompletionChoiceMessageModel(
      content: message,
      role: OpenAIChatMessageRole.user,
    ),
  ];

  final chatCompletion = await OpenAI.instance.chat.create(
    model: 'gpt-3.5-turbo',
    messages: messages,
  );

  return chatCompletion.choices.first.message.content;
}
