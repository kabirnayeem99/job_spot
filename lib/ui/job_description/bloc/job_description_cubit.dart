import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/company_description.dart';
import '../../../domain/entity/job_description.dart';
import '../../../domain/entity/job_description_page_state.dart';
import '../../../domain/entity/user_message.dart';
import '../../../domain/use_case/job_description/fetch_company_information_by_id_use_case.dart';
import '../../../domain/use_case/job_description/fetch_job_description_by_id_use_case.dart';

part 'job_description_state.dart';

class JobDescriptionCubit extends Cubit<JobDescriptionState> {
  JobDescriptionCubit() : super(JobDescriptionState.init());

  void loadJobDescription(String id) async {
    _loadJob(id);
    _loadCompany(id);
  }

  Future<void> _loadCompany(String id) async {
    FetchJobDescriptionByIdUseCase.invoke(id).then(
      (either) => either.fold(
        (error) => _addUserMessage(error),
        (jobDescription) {
          emit(state.copyWith(jobDescription: jobDescription));
        },
      ),
    );
  }

  Future<void> _loadJob(String id) async {
    FetchCompanyInformationByIdUseCase.invoke(id).then(
      (either) => either.fold(
        (error) => _addUserMessage(error),
        (companyInfo) {
          emit(state.copyWith(companyDescription: companyInfo));
        },
      ),
    );
  }

  Future<void> loadCompanyData() async {
    emit(state.copyWith(pageState: JobDescriptionPageState.company));
  }

  Future<void> loadDescriptionData() async {
    emit(state.copyWith(pageState: JobDescriptionPageState.description));
  }

  Future<void> loadApplicationData() async {
    emit(state.copyWith(pageState: JobDescriptionPageState.apply));
  }

  Future<void> loadAppliedData() async {
    emit(state.copyWith(pageState: JobDescriptionPageState.applied));
  }

  Future<void> selectedFilePickerResult(FilePickerResult? result) async {
    if (result == null) return;
    List<File?> files =
        result.paths.map((path) => path != null ? File(path) : null).toList();
    emit(state.copyWith(file: files[0]));
  }

  Future<void> removeFile() async {
    emit(state.copyWith(file: null));
  }

  void _addUserMessage(String message) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages =
        List<UserMessage>.from(currentMessages ?? [], growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    emit(state.copyWith(userMessages: messages));
  }

  void userMessageShown(int id) {
    final currentMessages = state.userMessages;
    final messages =
        List<UserMessage>.from(currentMessages ?? [], growable: true);
    messages.removeWhere((element) => element.id == id);

    emit(state.copyWith(userMessages: messages));
  }
}
