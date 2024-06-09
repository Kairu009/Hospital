namespace App\Http\Controllers;

use App\Models\Appointment;
use Illuminate\Http\Request;

class AppointmentController extends Controller {
    public function index() {
        $appointments = Appointment::with('patient', 'doctor')->get();
        return response()->json($appointments);
    }

    public function store(Request $request) {
        $existingAppointment = Appointment::where('doctor_id', $request->doctor_id)
            ->where('appointment_date', $request->appointment_date)
            ->where('status', 'booked')
            ->first();

        if ($existingAppointment) {
            return response()->json(['error' => 'Time slot already booked'], 400);
        }

        $appointment = Appointment::create([
            'patient_id' => $request->patient_id,
            'doctor_id' => $request->doctor_id,
            'appointment_date' => $request->appointment_date,
            'status' => 'booked'
        ]);

        return response()->json($appointment);
    }

    public function update(Request $request, $id) {
        $appointment = Appointment::findOrFail($id);
        $appointment->update($request->all());
        return response()->json($appointment);
    }

    public function destroy($id) {
        $appointment = Appointment::findOrFail($id);
        $appointment->status = 'cancelled';
        $appointment->save();
        return response()->json($appointment);
    }
}
