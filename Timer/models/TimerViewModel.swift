import Foundation

class TimerViewModel: ObservableObject {
    private var timer = Timer()
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    @Published var isDurationSelected = false
    @Published var duration = TimeInterval(60)
    @Published var state: ButtonState = .start
    @Published var durationText = ""
    /// タイマー設定時間経過後の時刻
    @Published var elapsedTime = ""

    func startTimer() {
        setUpText()
        state = .pause
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            self.duration -= 1
            makeTimeText()
            if self.duration == 0 {
                timer.invalidate()
                state = .start
                isDurationSelected = false
            }
        }
    }

    func cancelTimer() {
        timer.invalidate()
        state = .start
        isDurationSelected = false
    }

    func pauseTimer() {
        timer.invalidate()
        state = .restart
    }

    private func setUpText() {
        makeTimeText()
        makeDateText()
    }

    private func makeTimeText() {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        guard let text = formatter.string(from: duration) else { return }
        durationText = text
    }

    private func makeDateText() {
        elapsedTime = formatter.string(from: Date(timeInterval: duration, since: .now))
    }
}
