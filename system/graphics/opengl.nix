{ ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = false;
    # driSupport32Bit = true;
    # extraPackages = with pkgs; [
    #   vaapiVdpau
    #   libvdpau-va-gl
    # ];
  };
}

# I am using the proprietary nvidia driver with this config:



# ```
# 618693:0412/223607.303310:ERROR:browser_main_loop.cc(275)] Gtk: gtk_widget_get_scale_factor: assertion 'GTK_IS_WIDGET (widget)' failed
# DRM kernel driver 'nvidia-drm' in use. NVK requires nouveau.
# libEGL warning: egl: failed to create dri2 screen
# DRM kernel driver 'nvidia-drm' in use. NVK requires nouveau.
# [618746:0412/223607.632139:ERROR:gbm_wrapper.cc(253)] Failed to export buffer to dma_buf: No such file or directory (2)
# [618746:0412/223607.632271:ERROR:gbm_pixmap_wayland.cc(82)] Cannot create bo with format= RGBA_8888 and usage=SCANOUT
# [618746:0412/223607.632439:ERROR:gbm_wrapper.cc(253)] Failed to export buffer to dma_buf: No such file or directory (2)
# [618746:0412/223607.632497:ERROR:gbm_pixmap_wayland.cc(82)] Cannot create bo with format= RGBA_8888 and usage=GPU_READ
# [618746:0412/223607.632556:ERROR:shared_image_factory.cc(926)] CreateSharedImage: could not create backing.
# [618746:0412/223607.632610:ERROR:shared_image_factory.cc(758)] DestroySharedImage: Could not find shared image mailbox
# [618746:0412/223607.632716:ERROR:gpu_service_impl.cc(1089)] Exiting GPU process because some drivers can't recover from errors. GPU process will restart shortly.
# [618763:0412/223607.642137:ERROR:command_buffer_proxy_impl.cc(127)] ContextResult::kTransientFailure: Failed to send GpuControl.CreateCommandBuffer.
# [618693:0412/223607.657802:ERROR:gpu_process_host.cc(991)] GPU process exited unexpectedly: exit_code=8704
# DRM kernel driver 'nvidia-drm' in use. NVK requires nouveau.
# libEGL warning: egl: failed to create dri2 screen
# ```
