"""Beacon Configuration."""
# Beacon general info
beacon_id = 'org.nbis-ejprd.ga4gh-approval-beacon-test'
beacon_name = 'EJPRD Swedish Test Beacon'
api_version = 'v2.0.0'
uri = 'https://beacon:5050/api/'
default_beacon_granularity = 'record'
max_beacon_granularity = 'record'

#  Organization info
org_id = 'NBIS'  # Id of the organization
org_name = 'National Bioinformatics Infrastructure Sweden (NBIS)'  # Full name
org_description = ('NBIS is a distributed national bioinformatics infrastructure, supporting life sciences in Sweden.')
org_adress = ('Uppsala Biomedicine Center (BMC) '
              'Husargatan 3, '
              '751 23 Uppsala, Sweden')
org_welcome_url = 'https://nbis.se/'
org_contact_url = 'mailto:info@gdi.nbis.se'
org_logo_url = 'https://nbis.se/nbislogo-green.svg'
org_info = ''

# Project info
description = r"This Beacon is based on the GA4GH Beacon v2.0"
version = 'v2.0'
welcome_url = 'https://beacon:5050/api'
alternative_url = 'https://beacon:5050/api'
create_datetime = '2024-04-01T12:00:00Z'
update_datetime = ''

# Service
service_type = 'org.ga4gh:beacon:1.0.0'  # service type
service_url = 'https://beacon.ega-archive.org/api/services'
entry_point = False
is_open = True
documentation_url = 'https://github.com/EGA-archive/beacon-2.x/'  # Documentation of the service
environment = 'staging'  # Environment (production, development or testing/staging deployments)

# GA4GH
ga4gh_service_type_group = 'org.ga4gh'
ga4gh_service_type_artifact = 'beacon'
ga4gh_service_type_version = '1.0'

# Beacon handovers
beacon_handovers = {
  'handoverType': {
      'id': 'CUSTOM:000001',
      'label': 'Project description'
  },
  'note': 'Project description',
  'url': 'https://www.nist.gov/programs-projects/genome-bottle'
}

# CORS
cors_hosts = [
    "https://beacon-network-demo.ega-archive.org",
]

# database_schema = 'public' # comma-separated list of schemas
# database_app_name = 'beacon-appname' # Useful to track connections
# Database connection
database_host = 'mongo'
database_port = 27017
database_user = 'root'
database_password = 'example'
database_name = 'beacon'
database_auth_source = 'admin'
#database_certificate = '/certs/tls-combined.pem'
#database_cafile      = '/certs/ca.crt'

# Web server configuration
beacon_host        = '0.0.0.0'
beacon_port        = 5050
beacon_tls_enabled = False
beacon_tls_client  = False
beacon_cert        = '/certs/tls.crt'
beacon_key         = '/certs/tls.key'
CA_cert            = ''

# Permissions server configuration
permissions_url = 'http://beacon-permissions:5051'

# IdP endpoints (OpenID Connect/Oauth2)
idp_url = 'http://idp:8080/'
#idp_client_id     = '${data.vault_kv_secret_v2.oidc.data["client_id"]}'
#idp_client_secret = '${data.vault_kv_secret_v2.oidc.data["client_secret"]}'
#idp_scope         = 'openid profile email ga4gh_passport_v1'
#idp_authorize     = '${var.OIDC-provider}/authorize'
#idp_access_token  = '${var.OIDC-provider}/token'
#idp_introspection = '${var.OIDC-provider}/introspect'
#idp_user_info     = '${var.OIDC-provider}/userinfo'
#idp_logout        = '${var.OIDC-provider}/revoke'
#idp_redirect_uri  = 'https://${var.hostname-beacon}.${var.ingress-base}/login'

# UI
autocomplete_limit    = 16
autocomplete_ellipsis = '...'

# Ontologies
ontologies_folder = "ontologies"
