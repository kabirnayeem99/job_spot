import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_spot/domain/entity/company_description.dart';
import 'package:job_spot/domain/entity/job_description.dart';
import 'package:job_spot/domain/entity/job_description_page_state.dart';

part 'job_description_state.dart';

class JobDescriptionCubit extends Cubit<JobDescriptionState> {
  JobDescriptionCubit() : super(JobDescriptionState.init());

  Future<void> loadJobDescription(String id) async {

  }

  Future<void> selectedFilePickerResult(FilePickerResult? result) async {
    if (result == null) return;
    List<File> files = result.paths.map((path) => File(path ?? "")).toList();
    emit(state.copyWith(file: files[0]));
  }

  Future<void> remoteFile() async {
    emit(state.copyWith(file: null));
  }
}
