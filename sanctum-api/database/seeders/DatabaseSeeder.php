<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        User::create([
            "fullname" => "Francis Manuel G. Cabusas",
            "address" => "Cabuyao Laguna",
            "contact" => "099185753415",
            "email" => "francistengteng10@gmail.com",
            "password" => Hash::make('francis22'),
            "account_type" => 1,
        ]);
    }
}
