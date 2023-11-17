# 은행창구 관리 앱

## 팀원:busts_in_silhouette: 
| 프로필 사진 | <a href="https://github.com/Dongjun-developer"><img src="https://avatars.githubusercontent.com/u/97822621?v=4" width="90" height="90"></a> | <a href="https://github.com/bamsak"><img src="https://avatars.githubusercontent.com/u/114239407?v=4" width=90></a> | <a href="https://github.com/dpwns1234"><img src="https://avatars.githubusercontent.com/u/52391722?v=4" width=90></a> |
| ---- | ---------- | --------- | --------- |
| in Github | [@DongJun](https://github.com/Dongjun-developer) | [@bamsak](https://github.com/bamsak) | [@dpwns1234](https://github.com/dpwns1234) |
| in SeSAC | 망고 | 밤삭 | 요한 |



## 파일구조:file_folder:
- BankManagerConsoleApp
- Protocol
    - BankManagable.swift
- Model
    -  BankManager.swift
    -  Bank.swift
    -  Client.swift
    -  TaskType.swift
- Utility
    - Queue.swift
- BankProcess.swift
- main.swift
- BankManagerConsoleAppTests
    - BankManagerConsoleApp.swift


## 프로젝트 소개
여러 부서의 은행원이 고객의 은행 업무를 처리해주는 BankManager 콘솔 어플리케이션
- 2명의 예금 은행원과 1명의 대출 은행원이 고객의 은행 업무에 따라 각각 다른 업무 시간만큼 업무처리를 `consoleApp`으로 구현.

### 동작화면
![BankManagerConsole](https://github.com/tasty-code/ios-bank-manager/assets/97822621/b766b2d4-fca3-4adb-806f-db76d944a6c0)


### 프로젝트 설명

| 이름 | 타입 | 구현내용 |
| --- | --- | --- |
| BankManagable | Protocol | BankManager에서 채택되어 총 업무 시간, 고객을 큐에 삽입, 은행업무 시작 기능을 추상적으로 구현. BankManager의 여러 객체가 생길 경우 Bank와 BankManager와의 직접적인 의존성을 갖지않고 해당 protocol로 추상하여 BankManagable protocol에 의존성을 역전시켜 DIP를 적용 
| BankManager | Class | Bank의 업무를 직접적으로 처리하는 Model. BankManagable protocol을 채택하여 구현함.|
| Client | Struct | 식별 id, 은행 업무 타입을 프로퍼티로 가지고 있는 고객 |
| Bank | Struct | 총 업무 시간, 고객을 큐에 삽입과정을 BankManager에 시키는 업무, 은행업무 시작 기능 등 은행 업무 구현 |
| TaskType | Enum | 은행 업무에 따른 description 및 소요 시간 정의 |
| Queue | Struct | LinkedList를 활용한 queue의 enqueue, dequeue, clear, peek, isEmpty 기능 구현  |
| BankProcess | Class | project 실행 시 user와 소통하는 객체. user의 입력 받는 역할. |





## Trouble Shooting

https://github.com/tasty-code/ios-bank-manager/pull/36

https://github.com/tasty-code/ios-bank-manager/pull/43

https://github.com/tasty-code/ios-bank-manager/pull/49

