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
            "fullname" => "John Cena",
            "address" => "Cabuyao Laguna",
            "contact" => "09123456789",
            "email" => "john@gmail.com",
            "password" => Hash::make('password123'),
            "account_type" => 1,
        ]);
    }
}

