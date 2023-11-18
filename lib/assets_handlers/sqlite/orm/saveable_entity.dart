/// A class that stores a saved entity
class SaveableEntity<T> {
  const SaveableEntity({
    required this.entity,
    required this.isSaved,
    required this.isSavedByParent,
    this.id,
  });

  final T entity;
  final bool isSaved;
  final bool isSavedByParent;
  final int? id;

  SaveableEntity<T> copyWith({
    T? entity,
    bool? isSaved,
    bool? isSavedByParent,
    int? id,
  }) {
    return SaveableEntity<T>(
      entity: entity ?? this.entity,
      isSaved: isSaved ?? this.isSaved,
      isSavedByParent: isSavedByParent ?? this.isSavedByParent,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'SaveableEntity(entity: $entity, isSaved: $isSaved, isSavedByParent: $isSavedByParent, id: $id)';
  }

  @override
  bool operator ==(covariant SaveableEntity<T> other) {
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
