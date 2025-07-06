import '../repositories/note_repository.dart';

class DeleteNoteUseCase {
  DeleteNoteUseCase(this.repository);
  
  final NoteRepository repository;

  Future<void> call(String id) {
    return repository.deleteNote(id);
  }
}
