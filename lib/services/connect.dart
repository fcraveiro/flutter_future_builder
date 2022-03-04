import 'dart:developer';

import 'package:supabase/supabase.dart';
import 'model.dart';

const supabaseUrl = '';
const supabaseKey = '';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  void signUpUser(String email, String password) async {
    await client.auth.signUp(email, password);
  }

  Future<List<ClassPaciente>> getAll() async {
    final response = await client
        .from('pacientes')
        .select()
        .order('pacNome', ascending: true)
        .execute();

    if (response.error == null) {
      log(response.data.toString());
      final dataList = response.data as List;
      return (dataList.map((map) => ClassPaciente.fromJson(map)).toList());
    }

    // ignore: avoid_print
    print('Error fetching notes: ${response.error!.message}');
    return [];
  }
}
