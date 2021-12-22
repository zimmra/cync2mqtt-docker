cync2mqtt in docker configured for HASS-OS
### This is very scrapily put together/MVP/alpha for https://github.com/juanboro/cync2mqtt running in a docker container/Home Assistant addon. 

Currently pulls cync2mqtt via git then builds, future versions may store source within same repo. 

Currently you need to generate your cync_mesh.yaml configuration outside of this addon, it currently is to go in your config directory at /config/cync2mqtt/cync_mesh.yaml.
In the future I hope to implement configuration generation within the addon. 
