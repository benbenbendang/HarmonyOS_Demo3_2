import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''

  build() {
    Column({ space: 20 }) {
      Text("用户登录")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // 用户名输入框
      TextInput({ placeholder: "请输入用户名" })
        .width(260).height(40)
        .borderRadius(6)
        .backgroundColor('#FFFFFF')
        .padding({ left: 10 })
        .onChange((val: string) => this.username = val)

      // 密码输入框
      TextInput({ placeholder: "请输入密码" })
        .width(260).height(40)
        .borderRadius(6)
        .backgroundColor('#FFFFFF')
        .padding({ left: 10 })
        .type(InputType.Password)
        .onChange((val: string) => this.password = val)

      // 登录按钮
      Button("登录")
        .width(260).height(40)
        .backgroundColor('#3B82F6')
        .fontColor(Color.White)
        .borderRadius(6)
        .onClick(() => this.handleLogin())
    }
    .width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F3F4F6')
  }

  handleLogin() {
    if (this.username === 'admin' && this.password === '123456') {
      const now = new Date().toLocaleString()
      router.pushUrl({
        url: 'pages/UserPage',
        params: {
          currentUser: this.username,
          loginTime: now
        }
      })
    } else {
      promptAction.showToast({ message: "用户名或密码错误" })
    }
  }
}
