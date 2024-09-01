# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

job "nrj11" {
  datacenters = ["dc1"]

  group "ray-remote-task-demo" {
    count = 5
    restart {
      attempts = 0
      mode     = "fail"
    }

    reschedule {
      delay = "5s"
    }

    task "ray-server" {
      driver       = "rayRest"
      kill_timeout = "1m" // increased from default to accomodate ECS.

      config {
        task {
          namespace            = "public91"
          ray_cluster_endpoint = "http://192.168.165.189:8265"
          ray_serve_endpoint = "http://0.0.0.0:8000"
          actor                = "test_actor"
          runner               = "runner"
        }
      }
    }
  }
}
