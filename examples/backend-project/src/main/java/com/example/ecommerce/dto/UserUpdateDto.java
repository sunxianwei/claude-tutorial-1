package com.example.ecommerce.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 用户更新 DTO
 */
@Data
public class UserUpdateDto {

    @Size(min = 3, max = 50, message = "用户名长度必须在 3-50 之间")
    private String username;

    @Email(message = "邮箱格式不正确")
    private String email;

    private String role;

    private String avatar;
}
