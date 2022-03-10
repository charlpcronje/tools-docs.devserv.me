# Teedy Document Management

> This is a very nice document repository, here are some of the cool features


=== What is Toody About?

- **Modern and user-friendly interface:** As a content-oriented document management system, the user interface is not cluttered with buttons and menus, and works both on desktop and mobile.
- **Flexible search engine:** Document searching has never been easier thanks to the powerful full text search engine in Teedy. You can search in images (embedded OCR), DOCX, ODT, TXT, PDF and more.
- **Workflow:** Verify or validate your documents with people of your organization using workflows.
- **Users and groups access:** You have absolute control of who can access to your documents by granting access to users and groups.
- **Metadata:** Allows you to customize and classify your documents with more details such as description, tags, subject and type (Dublin Core standard).
- **Audit trail:** You can easily track any modifications of your documents with the information of who, when and which.
- **Interaction:** You can add comments or notes on documents.
- **Easy sharing:** You can share a document to someone even without a Teedy account by simply providing a document link.
- **Extend and enhance:** With the modern and documented REST API, you can create any app leveraging the power of Teedy.
- **Open Source:** Teedy is fully open source and developed under the view of the community.
- **Security** Your documents are safe with us! Our cloud is encrypted with the proven AES 256 bits algorithm and stored in secure datacenters in France. Not even we can access it!
- **Performance:** Instant browsing through your thousands of documents.
- **Automatic import:** Automatically import your documents from a mail account, a folder on your disk, a SMB
===

## List of Features

- Responsive user interface
- Optical character recognition
- LDAP authentication ![New!](https://www.sismics.com/public/img/new.png)
- Support image, PDF, ODT, DOCX, PPTX files
- Video file support
- Flexible search engine with suggestions and highlighting
- Full text search in all supported files
- All [Dublin Core](http://dublincore.org/) metadata
- Custom user-defined metadata ![New!](https://www.sismics.com/public/img/new.png)
- Workflow system ![New!](https://www.sismics.com/public/img/new.png)
- 256-bit AES encryption of stored files
- File versioning ![New!](https://www.sismics.com/public/img/new.png)
- Tag system with nesting
- Import document from email (EML format)
- Automatic inbox scanning and importing
- User/group permission system
- 2-factor authentication
- Hierarchical groups
- Audit log
- Comments
- Storage quota per user
- Document sharing by URL
- RESTful Web API
- Webhooks to trigger external service
- Fully featured Android client
- [Bulk files importer](https://github.com/sismics/docs/tree/master/docs-importer) (single or scan mode)
- Tested to one million documents

## Demo

A demo is available at [demo.teedy.io](https://demo.teedy.io)

- Guest login is enabled with read access on all documents
- `admin` login with "admin" password
- `demo` login with "password" password 


=== Install with Docker

A preconfigured Docker image is available, including OCR and media conversion tools, listening on port `8080`. The database is an embedded H2 database but PostgreSQL is also supported for more performance.

**The default admin password is "admin". Don't forget to change it before going to production.**

- Master branch, can be unstable. Not recommended for production use: `sismics/docs:latest`
- Latest stable version: `sismics/docs:v1.10`

The data directory is `/data`. Don't forget to mount a volume on it.

To build external URL, the server is expecting a `DOCS_BASE_URL` environment variable (for example https://teedy.mycompany.com)

### Available environment variables

- General
  - `DOCS_BASE_URL`: The base url used by the application. Generated url's will be using this as base.
  - `DOCS_GLOBAL_QUOTA`: Defines the default quota applying to all users.
  - `DOCS_BCRYPT_WORK`: Defines the work factor which is used for password hashing. The default is `10`. This value may be `4...31` including `4` and `31`. The specified value will be used for all new users and users changing their password. Be aware that setting this factor to high can heavily impact login and user creation performance.

- Admin
  - `DOCS_ADMIN_EMAIL_INIT`: Defines the e-mail-address the admin user should have upon initialization.
  - `DOCS_ADMIN_PASSWORD_INIT`: Defines the password the admin user should have upon initialization.  Needs to be a bcrypt hash.  **Be aware that `$` within the hash have to be escaped with a second `$`.**

- Database
  - `DATABASE_URL`: The jdbc connection string to be used by `hibernate`.
  - `DATABASE_USER`: The user which should be used for the database connection.
  - `DATABASE_PASSWORD`: The password to be used for the database connection.

- Language
  - `DOCS_DEFAULT_LANGUAGE`: The language which will be used as default. Currently supported values are:
    - `eng`, `fra`, `ita`, `deu`, `spa`, `por`, `pol`, `rus`, `ukr`, `ara`, `hin`, `chi_sim`, `chi_tra`, `jpn`, `tha`, `kor`, `nld`, `tur`, `heb`, `hun`, `fin`, `swe`, `lav`, `dan`

- E-Mail
  - `DOCS_SMTP_HOSTNAME`: Hostname of the SMTP-Server to be used by Teedy.
  - `DOCS_SMTP_PORT`: The port which should be used.
  - `DOCS_SMTP_USERNAME`: The username to be used.
  - `DOCS_SMTP_PASSWORD`: The password to be used.

### Examples

In the following examples some passwords are exposed in cleartext. This was done in order to keep the examples simple. We strongly encourage you to use variables with an `.env` file or other means to securely store your passwords.

#### Using the internal database

```yaml
version: '3'
services:
# Teedy Application
  teedy-server:
    image: sismics/docs:v1.10
    restart: unless-stopped
    ports:
      # Map internal port to host
      - 8080:8080
    environment:
      # Base url to be used
      DOCS_BASE_URL: "https://docs.example.com"
      # Set the admin email
      DOCS_ADMIN_EMAIL_INIT: "admin@example.com"
      # Set the admin password (in this example: "superSecure")
      DOCS_ADMIN_PASSWORD_INIT: "$$2a$$05$$PcMNUbJvsk7QHFSfEIDaIOjk1VI9/E7IPjTKx.jkjPxkx2EOKSoPS"
    volumes:
      - ./docs/data:/data
```

#### Using PostgreSQL

```yaml
version: '3'
services:
# Teedy Application
  teedy-server:
    image: sismics/docs:v1.10
    restart: unless-stopped
    ports:
      # Map internal port to host
      - 8080:8080
    environment:
      # Base url to be used
      DOCS_BASE_URL: "https://docs.example.com"
      # Set the admin email
      DOCS_ADMIN_EMAIL_INIT: "admin@example.com"
      # Set the admin password (in this example: "superSecure")
      DOCS_ADMIN_PASSWORD_INIT: "$$2a$$05$$PcMNUbJvsk7QHFSfEIDaIOjk1VI9/E7IPjTKx.jkjPxkx2EOKSoPS"
      # Setup the database connection. "teedy-db" is the hostname
      # and "teedy" is the name of the database the application
      # will connect to.
      DATABASE_URL: "jdbc:postgresql://teedy-db:5432/teedy"
      DATABASE_USER: "teedy_db_user"
      DATABASE_PASSWORD: "teedy_db_password"
    volumes:
      - ./docs/data:/data
    networks:
      - docker-internal
      - internet
    depends_on:
      - teedy-db

# DB for Teedy
  teedy-db:
    image: postgres:13.1-alpine
    restart: unless-stopped
    expose:
      - 5432
    environment:
      POSTGRES_USER: "teedy_db_user"
      POSTGRES_PASSWORD: "teedy_db_password"
      POSTGRES_DB: "teedy"
    volumes:
      - ./docs/db:/var/lib/postgresql/data
    networks:
      - docker-internal

networks:
  # Network without internet access. The db does not need
  # access to the host network.
  docker-internal:
    driver: bridge
    internal: true
  internet:
    driver: bridge
```

Manual installation
-------------------#### Requirements

- Java 11
- Tesseract 4 for OCR
- ffmpeg for video thumbnails
- mediainfo for video metadata extraction
- A webapp server like [Jetty](http://eclipse.org/jetty/) or [Tomcat](http://tomcat.apache.org/)

===