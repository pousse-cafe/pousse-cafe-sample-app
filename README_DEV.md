# Release

1. Change version manually in POM file.
2. ``./scripts/build_archetype.sh`` to test the archetype a last time before release
3. ``git commit -am "Set version X.Y.Z-Q." && git push origin`` to create actual release commit (replace X.Y.Z-Q by actual version)
4. ``mvn scm:tag`` to tag release commit and thus create a GitHub release (usually only for versions without qualifier)

# Deploy

## Snapshot release

Deployment is automatically handled by Travis (see .travis.yml for details).

## Other releases

Deployment is manual (because of package signing).

``./scripts/archetype_mvn.sh deploy -Ppousse-cafe-release`` where ``pousse-cafe-release`` profile enables
the generation of source and javadoc packages as well as the signing of all artifacts. Note that ``settings.xml``
file needs to contain related
profile section to configure GPG. For instance:

    <profile>
      <id>pousse-cafe-release</id>
      <properties>
        <gpg.executable>gpg2</gpg.executable>
        <gpg.keyname>deployer_email_address</gpg.keyname>
      </properties>
    </profile>

After that:

1. Go to [SonaType Nexus Repository Manager](https://oss.sonatype.org/)
2. In the Staging Repositories screen, locate the uploaded artifacts
3. Close the staging repository and, finally, release

# Check for dependency updates

Run the following command:

    mvn versions:display-dependency-updates
