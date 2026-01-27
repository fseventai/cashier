class Product {
  final String id;
  final String name;
  final String? code;
  final String? barcode;
  final String? unit;
  final String? groupId;
  final bool isActive;
  final bool isDefaultQuantity;
  final bool isService;
  final String? ageRestriction;
  final String? description;
  final String cost;
  final String markup;
  final String salePrice;
  final String? taxId;
  final bool priceIncludesTax;
  final bool priceChangeAllowed;
  final bool enableInventoryTracking;
  final String stockQuantity;
  final String? storageLocationId;
  final String minStockLevel;
  final String reorderPoint;
  final String? image;
  final String? color;
  final String? internalComments;
  final String? receiptNotes;
  final String? supplierNotes;
  final ProductGroup? group;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    this.code,
    this.barcode,
    this.unit,
    this.groupId,
    this.isActive = true,
    this.isDefaultQuantity = true,
    this.isService = false,
    this.ageRestriction,
    this.description,
    this.cost = '0',
    this.markup = '0',
    this.salePrice = '0',
    this.taxId,
    this.priceIncludesTax = true,
    this.priceChangeAllowed = false,
    this.enableInventoryTracking = true,
    this.stockQuantity = '0',
    this.storageLocationId,
    this.minStockLevel = '0',
    this.reorderPoint = '0',
    this.image,
    this.color,
    this.internalComments,
    this.receiptNotes,
    this.supplierNotes,
    this.group,
    this.createdAt,
    this.updatedAt,
  });

  Product copyWith({
    String? id,
    String? name,
    String? code,
    String? barcode,
    String? unit,
    String? groupId,
    bool? isActive,
    bool? isDefaultQuantity,
    bool? isService,
    String? ageRestriction,
    String? description,
    String? cost,
    String? markup,
    String? salePrice,
    String? taxId,
    bool? priceIncludesTax,
    bool? priceChangeAllowed,
    bool? enableInventoryTracking,
    String? stockQuantity,
    String? storageLocationId,
    String? minStockLevel,
    String? reorderPoint,
    String? image,
    String? color,
    String? internalComments,
    String? receiptNotes,
    String? supplierNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      barcode: barcode ?? this.barcode,
      unit: unit ?? this.unit,
      groupId: groupId ?? this.groupId,
      isActive: isActive ?? this.isActive,
      isDefaultQuantity: isDefaultQuantity ?? this.isDefaultQuantity,
      isService: isService ?? this.isService,
      ageRestriction: ageRestriction ?? this.ageRestriction,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      markup: markup ?? this.markup,
      salePrice: salePrice ?? this.salePrice,
      taxId: taxId ?? this.taxId,
      priceIncludesTax: priceIncludesTax ?? this.priceIncludesTax,
      priceChangeAllowed: priceChangeAllowed ?? this.priceChangeAllowed,
      enableInventoryTracking:
          enableInventoryTracking ?? this.enableInventoryTracking,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      storageLocationId: storageLocationId ?? this.storageLocationId,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      image: image ?? this.image,
      color: color ?? this.color,
      internalComments: internalComments ?? this.internalComments,
      receiptNotes: receiptNotes ?? this.receiptNotes,
      supplierNotes: supplierNotes ?? this.supplierNotes,
      group: group ?? group,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      barcode: json['barcode'] as String?,
      unit: json['unit'] as String?,
      groupId: json['groupId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isDefaultQuantity: json['isDefaultQuantity'] as bool? ?? true,
      isService: json['isService'] as bool? ?? false,
      ageRestriction: json['ageRestriction'] as String?,
      description: json['description'] as String?,
      cost: json['cost'] as String? ?? '0',
      markup: json['markup'] as String? ?? '0',
      salePrice: json['salePrice'] as String? ?? '0',
      taxId: json['taxId'] as String?,
      priceIncludesTax: json['priceIncludesTax'] as bool? ?? true,
      priceChangeAllowed: json['priceChangeAllowed'] as bool? ?? false,
      enableInventoryTracking: json['enableInventoryTracking'] as bool? ?? true,
      stockQuantity: json['stockQuantity'] as String? ?? '0',
      storageLocationId: json['storageLocationId'] as String?,
      minStockLevel: json['minStockLevel'] as String? ?? '0',
      reorderPoint: json['reorderPoint'] as String? ?? '0',
      image: json['image'] as String?,
      color: json['color'] as String?,
      internalComments: json['internalComments'] as String?,
      receiptNotes: json['receiptNotes'] as String?,
      supplierNotes: json['supplierNotes'] as String?,
      group: json['group'] == null
          ? null
          : ProductGroup.fromJson(json['group'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'barcode': barcode,
      'unit': unit,
      'groupId': groupId,
      'isActive': isActive,
      'isDefaultQuantity': isDefaultQuantity,
      'isService': isService,
      'ageRestriction': ageRestriction,
      'description': description,
      'cost': cost,
      'markup': markup,
      'salePrice': salePrice,
      'taxId': taxId,
      'priceIncludesTax': priceIncludesTax,
      'priceChangeAllowed': priceChangeAllowed,
      'enableInventoryTracking': enableInventoryTracking,
      'stockQuantity': stockQuantity,
      'storageLocationId': storageLocationId,
      'minStockLevel': minStockLevel,
      'reorderPoint': reorderPoint,
      'image': image,
      'color': color,
      'internalComments': internalComments,
      'receiptNotes': receiptNotes,
      'supplierNotes': supplierNotes,
      'group': group?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class ProductGroup {
  final String id;
  final String name;
  final String? parentId;
  final String? description;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductGroup({
    required this.id,
    required this.name,
    this.parentId,
    this.description,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  ProductGroup copyWith({
    String? id,
    String? name,
    String? parentId,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Tax {
  final String id;
  final String name;
  final String rate;

  const Tax({required this.id, required this.name, required this.rate});

  Tax copyWith({String? id, String? name, String? rate}) {
    return Tax(
      id: id ?? this.id,
      name: name ?? this.name,
      rate: rate ?? this.rate,
    );
  }

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'] as String,
      name: json['name'] as String,
      rate: json['rate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'rate': rate};
  }
}

class StorageLocation {
  final String id;
  final String name;

  const StorageLocation({required this.id, required this.name});

  StorageLocation copyWith({String? id, String? name}) {
    return StorageLocation(id: id ?? this.id, name: name ?? this.name);
  }

  factory StorageLocation.fromJson(Map<String, dynamic> json) {
    return StorageLocation(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
