<?php

namespace App\Http\Controllers;

use App\Models\MedicalRecord;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Admin;
use App\Models\Doctor;
use App\Models\Patient;

class MedicalRecordController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function storeRecord(Request $request)
    {
        $request->validate([
            'patient_id' => ['required', 'numeric'],
            'doctor_id' => ['required', 'numeric'],
            'illness' => ['required', 'string', 'max:255'],
            'diagnosis' => ['required', 'string', 'max:255'],
            'treatment' => ['required', 'string', 'max:255'],
            'remarks' => ['required', 'string', 'max:255'],
        ]);

        $user = MedicalRecord::create([
            'patient_id' => $request->patient_id,
            'doctor_id' => $request->doctor_id,
            'illness' => $request->illness,
            'diagnosis' => $request->diagnosis,
            'treatment' => $request->treatment,
            'remarks' => $request->remarks,
        ]);

        return response()->noContent();
    }

    /**
     * Display the specified resource.
     */
    public function showRecord($id)
    {
        return MedicalRecord::findOrFail($id);
    }

    /**
     * Display the specified resource.
     */
    public function showRecordsForAdmin()
    {
        return MedicalRecord::with(['doctor', 'patient'])->get();
    }

        /**
     * Display the specified resource.
     */
    public function showRecordsForDoctor()
    {
        $doctor = Doctor::where('user_id', auth()->user()->id)->first();

        return MedicalRecord::where('doctor_id', $doctor->id)->with(['doctor', 'patient'])->get();
    }

        /**
     * Display the specified resource.
     */
    public function showRecordsForPatient()
    {
        $patient = Patient::where('user_id', auth()->user()->id)->first();

        return MedicalRecord::where('patient_id', $patient->id)->with(['doctor', 'patient'])->get();
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(MedicalRecord $medicalRecord)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function updateRecord(Request $request, $id)
    {
        $request->validate([
            'patient_id' => ['numeric', 'nullable'],
            'doctor_id' => ['numeric', 'nullable'],
            'illness' => ['required', 'string', 'max:255'],
            'diagnosis' => ['required', 'string', 'max:255'],
            'treatment' => ['required', 'string', 'max:255'],
            'remarks' => ['required', 'string', 'max:255'],
        ]);

        $medicalRecord = MedicalRecord::findOrFail($id);

        if ($request->patient_id) {
            $medicalRecord->patient_id = $request->patient_id;
        }

        if ($request->doctor_id) {
            $medicalRecord->doctor_id = $request->doctor_id;
        }
        
        $medicalRecord->illness = $request->illness;
        $medicalRecord->diagnosis = $request->diagnosis;
        $medicalRecord->treatment = $request->treatment;
        $medicalRecord->remarks = $request->remarks;

        $medicalRecord->save();

        return response()->noContent();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroyRecord($id)
    {
        $medicalRecord = MedicalRecord::find($id);

        $medicalRecord->delete();

        return response()->noContent();
    }
}
