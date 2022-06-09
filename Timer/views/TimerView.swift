import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel = TimerViewModel()
    private static let timerSize = UIScreen.main.bounds.width * 0.8
    private static let width = UIScreen.main.bounds.width * 0.95

    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            if viewModel.isDurationSelected {
                timer()
            } else {
                DurationPickerView(duration: $viewModel.duration)
            }
            controllers()
            Spacer().frame(height: 30)
            alermSetting()
            Spacer()
        }
    }

    private func timer() -> some View {
        ZStack {
            Circle()
                .stroke(Color.mint, lineWidth: 8)
            VStack {
                Spacer()
                Text(viewModel.durationText)
                    .font(.system(size: 85))
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.gray)
                    Text(viewModel.elapsedTime)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .frame(width: Self.timerSize, height: Self.timerSize)
    }

    private func controllers() -> some View {
        HStack {
            makeControlButton(.cancel)
                .opacity(viewModel.isDurationSelected ? 1 : 0.5)
                .onTapGesture {
                    if viewModel.isDurationSelected {
                        viewModel.cancelTimer()
                    }
                }
            Spacer()
            makeControlButton(viewModel.state)
                .onTapGesture {
                    if viewModel.state == .start || viewModel.state == .restart {
                        viewModel.isDurationSelected = true
                        viewModel.startTimer()
                    } else {
                        viewModel.pauseTimer()
                    }
                }
        }
        .padding(.horizontal, 20)
        .padding(.top, -10)
    }

    private func makeControlButton(_ type: ButtonState) -> some View {
        ZStack {
            Circle()
                .fill(type.backgroundColor)
                .frame(width: 90, height: 90)
            Circle()
                .stroke(.white, lineWidth: 1.5)
                .frame(width: 85, height: 85)
            Text(type.buttonText)
                .font(.system(size: 13))
                .foregroundColor(.black)
        }
    }

    private func alermSetting() -> some View {
        HStack {
            Text("タイマー終了時")
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
            // 音の種類
            Text("レーダー")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .opacity(0.5)
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .padding(.horizontal, 10)
        .frame(width: Self.width, height: 60)
        .background(Color.gray)
        .opacity(0.8)
        .cornerRadius(10)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
