import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 定义一个接口来描述传递的参数
interface LoginParams {
  currentUser?: string
  loginTime?: string
}

@Entry
@Component
struct UserPage {
  private currentUser: string = ''
  private loginTime: string = ''

  // 模拟用户列表
  private userList: string[] = ['admin', 'alice', 'bob', 'charlie', 'david']

  aboutToAppear() {
    const p = router.getParams() as LoginParams
    this.currentUser = p?.currentUser ?? ''
    this.loginTime = p?.loginTime ?? ''
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        // 顶部用户信息卡片
        Column() {
          Row({ space: 12 }) {
            Image($r('app.media.ycw')) // 需要 avatar.png
              .width(60).height(60).borderRadius(30)
              .border({ width: 2, color: '#FFFFFF' })

            Column({ space: 6 }) {
              Text(this.currentUser !== '' ? this.currentUser : "未知用户")
                .fontSize(22).fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text(`登录时间：${this.loginTime}`)
                .fontSize(14)
                .fontColor('#F0F0F0')
            }
            Blank().layoutWeight(1)
            // 在线状态徽章
            Text("● 在线")
              .fontSize(14)
              .fontColor('#22FF88')
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('90%')
        .padding(20)
        .margin({ top: 20 })
        .linearGradient({ // 渐变背景
          angle: 135,
          colors: [
            ['#3B82F6', 0.0], // 蓝
            ['#8B5CF6', 1.0]  // 紫
          ]
        })
        .borderRadius(20)
        .shadow({ radius: 12, color: '#33000000', offsetX: 0, offsetY: 6 })

        // 用户列表标题
        Text("用户列表")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 20, top: 10, bottom: 10 })

        // 用户列表
        Column({ space: 16 }) {
          ForEach(this.userList, (user: string, index: number) => {
            Row() {
              Image($r('app.media.ycw'))
                .width(40).height(40).borderRadius(20).margin({ right: 12 })
              Text(user)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
              Blank().layoutWeight(1)
            }
            .width('90%')
            .padding(16)
            .borderRadius(16)
            .shadow({ radius: 8, color: '#22000000', offsetX: 0, offsetY: 4 })
            .linearGradient({ // 给每个用户卡片一个渐变
              angle: 90,
              colors: [
                [this.pickCardColor(index, 0), 0.0],
                [this.pickCardColor(index, 1), 1.0]
              ]
            })
            .onClick(() => {
              promptAction.showToast({ message: `你选择了 ${user}` })
            })
          })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .linearGradient({ // 页面背景
        angle: 180,
        colors: [
          ['#E0F2FE', 0.0],
          ['#F9FAFB', 1.0]
        ]
      })
    }
    .scrollable(ScrollDirection.Vertical)
  }

  // 根据索引给用户卡片挑选不同颜色渐变
  pickCardColor(index: number, pos: number): string {
    const gradients: string[][] = [
      ['#93C5FD', '#BFDBFE'], // 蓝
      ['#6EE7B7', '#A7F3D0'], // 绿
      ['#C4B5FD', '#DDD6FE'], // 紫
      ['#FCA5A5', '#FECACA'], // 红
      ['#FCD34D', '#FDE68A']  // 黄
    ]
    return gradients[index % gradients.length][pos]
  }
}
