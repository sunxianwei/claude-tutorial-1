package com.example.ecommerce.controller;

import com.example.ecommerce.dto.UserCreateDto;
import com.example.ecommerce.dto.UserUpdateDto;
import com.example.ecommerce.entity.User;
import com.example.ecommerce.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 用户管理 REST Controller
 */
@RestController
@RequestMapping("/api/users")
@Tag(name = "用户管理", description = "用户的 CRUD 操作")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 获取用户列表（分页）
     */
    @GetMapping
    @Operation(summary = "获取用户列表", description = "分页获取所有用户")
    public ResponseEntity<Page<User>> getUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        Page<User> users = userService.findAll(PageRequest.of(page, size));
        return ResponseEntity.ok(users);
    }

    /**
     * 根据 ID 获取用户
     */
    @GetMapping("/{id}")
    @Operation(summary = "获取用户详情", description = "根据 ID 获取单个用户")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return userService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * 创建新用户
     */
    @PostMapping
    @Operation(summary = "创建用户", description = "创建一个新用户")
    public ResponseEntity<User> createUser(@Valid @RequestBody UserCreateDto userDto) {
        User createdUser = userService.create(userDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdUser);
    }

    /**
     * 更新用户信息
     */
    @PutMapping("/{id}")
    @Operation(summary = "更新用户", description = "更新用户信息")
    public ResponseEntity<User> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UserUpdateDto userDto
    ) {
        return userService.update(id, userDto)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * 删除用户
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "删除用户", description = "根据 ID 删除用户")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        if (userService.delete(id)) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
