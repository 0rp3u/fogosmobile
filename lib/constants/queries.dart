class Queries {
  static const String getContributorsInformation = """query ReadContributors {
  repository(owner: "FogosPT", name: "fogosmobile") {
    collaborators(first: 50) {
      nodes {
        avatarUrl
        name
        login
        bio
        websiteUrl
        location
      }
    }
  }
}
""";
}