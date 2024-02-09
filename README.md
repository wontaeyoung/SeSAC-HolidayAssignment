# 구조체 + 스트림 방식

- 구조체는 불변성으로 인해 자기 자신에 새 인스턴스를 할당할 수 없다.
- Self를 리턴하면서 스트림 방식으로 사용하고 싶어도, 원본을 변경하고 반환하는 스트림 방식은 사용이 불가하다.
- 인스턴스를 가변인 변수에 담아두면 변경이 된 self를 반환할 수 있다.
  - 하지만 첫 반환 이후에는 불변성으로 다시 체이닝을 하는 것이 불가하다.
  - 리턴된 그 self도 원본의 복사본에 해당한다.
- 구조체에서 스트림 방식으로 함수를 사용하고 싶다면, 원본을 유지하고 새로운 인스턴스에 변경을 적용한 다음 반환하는 방식으로 구현해야한다.
