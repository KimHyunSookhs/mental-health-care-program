# Calmi (Calm + I)
나를 위한 차분한 공간이라는 뜻의 의미


![image](https://github.com/user-attachments/assets/01f8d737-a002-4ab7-bedd-d2b6e6fda01f)
![image](https://github.com/user-attachments/assets/74004a93-15d1-4656-8470-febc2e864fa3)
![image](https://github.com/user-attachments/assets/1c268341-2bd4-4e98-b4eb-943826689158)
![image](https://github.com/user-attachments/assets/cc58fb0f-1b93-4206-b010-0519242ac7c6)

|SplashScreen|회원가입|
|-----|-------|
|![image](https://github.com/user-attachments/assets/e981a6d2-0611-4b7c-a214-a2cc84330269)|![image](https://github.com/user-attachments/assets/f832fcc2-9404-4aec-950d-f9bda8ffcbd8)|

스플래쉬 스크린 활용 및 회원가입시 유효성 검사를 통해 회원가입과 로그인을 진행하도록 함

![image](https://github.com/user-attachments/assets/82f73be2-e17e-4403-a2bf-5fef70f24bfb)


firebase에 하루하루 챌린지를 저장하고 한주의 실천률을 볼 수 있도록 함

![image](https://github.com/user-attachments/assets/203ffd6c-6d6c-462a-a5fa-f83badca7138)

google_generative_ai 패키지를 활용하여 Gemini를 모델과 Riverpod으로 상태관리를 통해 고민상담 및 위로를 해주는 챗 봇(토닥토닥)생성

```
//레포지토리에서 프롬포트 초기화
  Future<void> setSystemPrompt(String prompt) async {
    _chatSession = _model.startChat(history: [
      Content.model([TextPart(prompt)]), // 첫 번째 메시지로 시스템 프롬프트 전달
    ]);
  }
//Riverpod을 활용해 챗봇 생성 및 상태관리
  Future<void> initializeChatBot(String initialSystemPrompt) async {
    try {
      await repository.setSystemPrompt(initialSystemPrompt);
      state = state.copyWith(chatList: [
        ...state.chatList,
        ChatMessage(message: '안녕하세요! 무엇을 도와드릴까요?', isHuman: false)
      ]);
    } catch (e) {
      throw Exception('챗봇 초기화에 실패했습니다: $e');
    }
  }
```
![image](https://github.com/user-attachments/assets/43e4759b-509d-490b-8c90-3d11a4758d3f)

명상 탭을 활용해 명상과 ASMR듣기 좋은 여러 유튜브 공유
