#!/usr/bin/env bash
gunicorn -c app_api_config.py app_api:app
