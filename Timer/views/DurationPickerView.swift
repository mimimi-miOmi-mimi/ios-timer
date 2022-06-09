import SwiftUI

struct DurationPickerView: UIViewRepresentable {
    @Binding var duration: TimeInterval

    final class Coordinator: NSObject {
        let parent: DurationPickerView

        init(_ parent: DurationPickerView) {
            self.parent = parent
        }

        @objc func updateDuration(datePicker: UIDatePicker) {
            parent.duration = datePicker.countDownDuration
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.countDownDuration = duration
    }
}
