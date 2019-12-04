Instructions

1. Create xml file  config.xml in /Config directory.

2. Paste the following, filling out as required.

```xml
	<?xml version="1.0" encoding="UTF-8"?>

	<config>

		<physical_file_path></physical_file_path>

		<site_name></site_name>

		<host_name></host_name>

		<use_app_poool_identity></use_app_poool_identity>

		<app_pool_identity_username></app_pool_identity_username>

		<app_pool_identity_pass></app_pool_identity_pass>

		<cert_subject></cert_subject>

	</config>
```

3. Move requires certificates in the /Certificates directory

4. Run by:
	powershell.exe -File ./Script/Setup-IISWebsite.ps1
