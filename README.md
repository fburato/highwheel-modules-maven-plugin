# Highwheel modules maven plugin

The `highwheel-modules-maven-plugin` allows to perform an [highwheel-modules](https://github.com/fburato/highwheel-modules)
static code analysis on a maven project.

## Build

To build the plugin, run:

```
mvn clean
```

## Using the plugin

In order to run the plugin on a project execute:

```
mvn com.github.fburato:highwheel-modules-maven-plugin:analyse
```

You can also run a specific version of the plugin without including it in your build with:

```
mvn com.github.fburato:highwheel-modules-maven-plugin:2.0.1:analyse
```
The plugin will:

* Read a module specification file named `spec.hwm` in the project base-directory and compile it, reporting any
  errors.
* Read all `*.class` files in the project output directory (`target/classes`)
* Start a strict analysis using the specification read from `spec.hwm` on the resources passed.
* Provide the result of the analysis and the fan-in/fan-out measurement on all modules.
* The build will fail if any of the rules are violated

It is possible to change the behaviour of the plugin as follows:

* `-DhwmSpecFiles=<comma separated list of paths to spec files>`: use the paths provided instead of `spec.hwm` from the base dir if the path is
  relative, otherwise use the path as is if the path is absolute.
* `-DhwmChildOnly=true`: in a multi-module build, run the analysis only on the child modules (skips pom packaging modules).
* `-DhwmParentOnly=true`: in a multi-module build, run the analysis only on the parent (skips non-pom packaging modules).
* `-DhwmEvidenceLimit=<integer>`: limit the pieces of evidence that are displayed when the analysis fails (i.e. code
  dependencies between the modules that make the dependency hold or not hold).

In a multi-module build, the plugin will use all the child output directories as elements of the analysis.

If you want to prevent one module from being analysed, add the `<hwmSkip>true</hwmSkip>` property to the configuration of the
plugin.

### Add the plugin to your build
Add the following dependency to your build/plugins section:

```xml
<dependency>
    <groupId>com.github.fburato</groupId>
    <artifactId>highwheel-modules-maven-plugin</artifactId>
    <version>2.0.2</version>
</dependency>
```

And configure it to run the appropriate phase.
