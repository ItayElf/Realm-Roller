/// A class that stores a saved entity
class SavedEntity<T> {
  const SavedEntity({
    required this.entity,
    required this.isSaved,
    required this.isSavedByParent,
    required this.id,
  });

  final T entity;
  final bool isSaved;
  final bool isSavedByParent;
  final int id;

  SavedEntity<T> copyWith({
    T? entity,
    bool? isSaved,
    bool? isSavedByParent,
    int? id,
  }) {
    return SavedEntity<T>(
      entity: entity ?? this.entity,
      isSaved: isSaved ?? this.isSaved,
      isSavedByParent: isSavedByParent ?? this.isSavedByParent,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'SavedEntity(entity: $entity, isSaved: $isSaved, isSavedByParent: $isSavedByParent, id: $id)';
  }

  @override
  bool operator ==(covariant SavedEntity<T> other) {
    if (identical(this, other)) return true;

    return other.entity == entity &&
        other.isSaved == isSaved &&
        other.isSavedByParent == isSavedByParent &&
        other.id == id;
  }

  @override
  int get hashCode {
    return entity.hashCode ^
        isSaved.hashCode ^
        isSavedByParent.hashCode ^
        id.hashCode;
  }
}
