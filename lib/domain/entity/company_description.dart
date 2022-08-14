class CompanyDescription {
  final String name;
  final String about;
  final String website;
  final String industry;
  final int employees;
  final String headOfficeAddress;
  final String type;
  final int foundationDate;
  final String specialisation;
  final List<String> companyGalleryImages;

  CompanyDescription({
    required this.name,
    required this.about,
    required this.website,
    required this.industry,
    required this.employees,
    required this.headOfficeAddress,
    required this.type,
    required this.foundationDate,
    required this.specialisation,
    required this.companyGalleryImages,
  });

  static CompanyDescription generateMockCompanyDescription() {
    return CompanyDescription(
      name: "Red Hat Linux",
      about:
          "Red Hat, Inc. is an American IBM subsidiary software company that provides open source software products to enterprises. ",
      website: "redhat.com",
      industry: "Computer software",
      employees: 19000,
      headOfficeAddress: "Raleigh, North Carolina, U.S.",
      type: "Worldwide",
      foundationDate: 1993,
      specialisation:
          "Linux, Virtualization, Satellite, Infrastructure for Virtualization",
      companyGalleryImages: [
        "https://qph.fs.quoracdn.net/main-qimg-88b1c73fa271f84322928b6ee0789cd3",
        "https://qph.fs.quoracdn.net/main-qimg-88b1c73fa271f84322928b6ee0789cd3",
        "https://qph.fs.quoracdn.net/main-qimg-88b1c73fa271f84322928b6ee0789cd3",
      ],
    );
  }

  @override
  String toString() {
    return 'CompanyDescription{name: $name, about: $about, website: $website, industry: $industry, employees: $employees, headOfficeAddress: $headOfficeAddress, type: $type, foundationDate: $foundationDate, specialisation: $specialisation, companyGalleryImages: $companyGalleryImages}';
  }
}
