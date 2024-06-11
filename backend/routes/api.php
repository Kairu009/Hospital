<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\MedicalRecordController;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user()->load(['admin', 'doctor', 'patient']);;
});

Route::middleware(['guest'])->post('/register', [RegisteredUserController::class, 'store'])->name('register');
Route::middleware(['guest'])->post('/login', [AuthenticatedSessionController::class, 'login'])->name('login');
Route::middleware(['auth:sanctum'])->post('/logout', [AuthenticatedSessionController::class, 'destroy'])->name('logout');

Route::middleware(['auth:sanctum'])->get('/patients', [PatientController::class, 'showPatients'])->name('showPatients');
Route::middleware(['auth:sanctum'])->get('/doctors', [DoctorController::class, 'showDoctors'])->name('showDoctors');

Route::middleware(['auth:sanctum'])->get('/admin-records', [MedicalRecordController::class, 'showRecordsForAdmin'])->name('showRecordsForAdmin');
Route::middleware(['auth:sanctum'])->get('/doctor-records', [MedicalRecordController::class, 'showRecordsForDoctor'])->name('showRecordsForDoctor');
Route::middleware(['auth:sanctum'])->get('/patient-records', [MedicalRecordController::class, 'showRecordsForPatient'])->name('showRecordsForPatient');

Route::middleware(['auth:sanctum'])->get('/records/{id}', [MedicalRecordController::class, 'showRecord'])->name('showRecord');
Route::middleware(['auth:sanctum'])->post('/records', [MedicalRecordController::class, 'storeRecord'])->name('storeRecord');
Route::middleware(['auth:sanctum'])->put('/records/{id}', [MedicalRecordController::class, 'updateRecord'])->name('updateRecord');
Route::middleware(['auth:sanctum'])->delete('/records/{id}', [MedicalRecordController::class, 'destroyRecord'])->name('destroyRecord');