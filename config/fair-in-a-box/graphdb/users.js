{
    "users" : {
      "admin" : {
        "username" : "admin",
        "password" : "{bcrypt}$2y$10$kKYhIp.vWraVuWoRaUflXO.Sj4bqPa5b8.hHENuK7yps2N3zDT0NK",
        "grantedAuthorities" : [ "ROLE_ADMIN" ],
        "appSettings" : {
          "DEFAULT_INFERENCE" : true,
          "DEFAULT_VIS_GRAPH_SCHEMA" : true,
          "DEFAULT_SAMEAS" : true,
          "IGNORE_SHARED_QUERIES" : false,
          "EXECUTE_COUNT" : true
        },
        "dateCreated" : 1712449776062
      },
      "fdp" : {
        "username" : "fdp",
        "password" : "{bcrypt}$2a$10$DeDQ/BlwIqjNl7r22ERQTeN9BKVicXiq43MQKRnWAKYbPdwp8PCHu",
        "grantedAuthorities" : [ "ROLE_USER", "READ_REPO_fdp", "WRITE_REPO_fdp" ],
        "appSettings" : {
          "DEFAULT_SAMEAS" : true,
          "DEFAULT_INFERENCE" : true,
          "EXECUTE_COUNT" : true,
          "IGNORE_SHARED_QUERIES" : false,
          "DEFAULT_VIS_GRAPH_SCHEMA" : true
        },
        "dateCreated" : 1712452207606
      },
      "beacon" : {
        "username" : "beacon",
        "password" : "{bcrypt}$2a$10$DeDQ/BlwIqjNl7r22ERQTeN9BKVicXiq43MQKRnWAKYbPdwp8PCHu",
        "grantedAuthorities" : [ "ROLE_USER", "READ_REPO_caresm" ],
        "appSettings" : {
          "DEFAULT_SAMEAS" : true,
          "DEFAULT_INFERENCE" : true,
          "EXECUTE_COUNT" : true,
          "IGNORE_SHARED_QUERIES" : false,
          "DEFAULT_VIS_GRAPH_SCHEMA" : true
        },
        "dateCreated" : 1712452207606
      }
    }
  }