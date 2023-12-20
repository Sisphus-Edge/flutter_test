List<String> generateSectionFiles() {
  return [
    // 'Section 1',
    // 'Section 2',
    // 'Section 3',
    // 'Section 4',
    // 'Section 5',
    // 'Section 6',
    // 'Section 7',
    'assets/image/login/1.png',
    'assets/image/login/3.png',
    'assets/image/login/1.png',
    'assets/image/login/2.png',
    'assets/image/login/3.png',
    'assets/image/login/2.png',
    // 可以添加更多头像文件路径...
  ];
}


void navigateToProfile() {
  // 在这里执行导航到个人资料页面的操作
  print('object');
}

void navigateToMessages() {
  // 在这里执行导航到消息页面的操作
}

void navigateToSettings() {
  // 在这里执行导航到设置页面的操作
}

void navigateToSettings2() {
  // 在这里执行导航到设置页面的操作
}
void navigateToSettings3() {
  // 在这里执行导航到设置页面的操作
}
// 构建处理函数列表
List<Function()> buildOnTapHandlers() {
  return [
    navigateToProfile,
    navigateToMessages,
    navigateToSettings,
    navigateToSettings2,
    navigateToSettings3,

    // 添加更多的处理函数...
  ];
}